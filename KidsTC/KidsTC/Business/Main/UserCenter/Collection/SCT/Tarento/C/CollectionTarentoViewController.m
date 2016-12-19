//
//  CollectionTarentoViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionTarentoViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "SegueMaster.h"

#import "CollectionTarentoModel.h"
#import "CollectionTarentoView.h"

#import "ArticleUserCenterViewController.h"

@interface CollectionTarentoViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionTarentoView *tarentoView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectionTarentoViewController

- (void)loadView {
    
    CollectionTarentoView *tarentoView = [[CollectionTarentoView alloc] init];
    tarentoView.delegate = self;
    self.view  = tarentoView;
    self.tarentoView = tarentoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    self.tarentoView.editing = editing;
}

#pragma mark - CollectionSCTBaseViewDelegate

- (void)collectionSCTBaseView:(CollectionSCTBaseView *)view actionType:(CollectionSCTBaseViewActionType)type value:(id)value completion:(void (^)(id))completion {
    switch (type) {
        case CollectionSCTBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
        case CollectionSCTBaseViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case CollectionSCTBaseViewActionTypeUserArticleCenter:
        {
            ArticleUserCenterViewController *controller = [[ArticleUserCenterViewController alloc]init];
            controller.userId = value;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case CollectionSCTBaseViewActionTypeDelete:
        {
            [self delete:value completion:^(BOOL success) {
                if(completion)completion(@(success));
            }];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pagecount":@(CollectionSCTPageCount)};
    [Request startWithName:@"GET_USER_COLLECTED_ARTICLE_AUTHOR" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectionTarentoModel *model = [CollectionTarentoModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.tarentoView.items = self.items;
        [self.tarentoView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tarentoView dealWithUI:0];
    }];
}

- (void)delete:(CollectionTarentoItem *)item completion:(void(^)(BOOL success))completion{
    if (![item.authorNo isNotNull]) {
        [[iToast makeText:@"作者编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    NSDictionary *param = @{@"authorId":item.authorNo,
                            @"isFollow":@(0)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"USER_FOLLOW_AUTHOR" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if (completion) completion(YES);
        [TCProgressHUD dismissSVP];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}

@end
