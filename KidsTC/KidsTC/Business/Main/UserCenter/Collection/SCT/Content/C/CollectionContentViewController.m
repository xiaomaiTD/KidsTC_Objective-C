//
//  CollectionContentViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionContentViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "KTCFavouriteManager.h"
#import "RecommendDataManager.h"

#import "CollectionContentModel.h"
#import "CollectionContentView.h"

@interface CollectionContentViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionContentView *contentView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectionContentViewController

- (void)loadView {
    
    CollectionContentView *contentView = [[CollectionContentView alloc] init];
    contentView.delegate = self;
    self.view  = contentView;
    self.contentView = contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    self.contentView.editing = editing;
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
        case CollectionSCTBaseViewActionTypeDelete:
        {
            [self delete:value completion:^(BOOL success) {
                if(completion)completion(@(success));
            }];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    if (!self.contentView.noMoreListData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"page":@(self.page),
                                @"pageCount":@(CollectionSCTPageCount)};
        [Request startWithName:@"GET_USER_COLLECT_ARTICLE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            CollectionContentModel *model = [CollectionContentModel modelWithDictionary:dic];
            if (refresh) {
                self.items = model.data;
            }else{
                NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
                [items addObjectsFromArray:model.data];
                self.items = [NSArray arrayWithArray:items];
            }
            self.contentView.items = self.items;
            [self.contentView dealWithUI:model.data.count isRecommend:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.contentView dealWithUI:0 isRecommend:NO];
        }];
    }else{
        [[RecommendDataManager shareRecommendDataManager] loadRecommendContentRefresh:YES pageCount:5 successBlock:^(NSArray<ArticleHomeItem *> *data) {
            [self.contentView dealWithUI:data.count isRecommend:YES];
        } failureBlock:^(NSError *error) {
            [self.contentView dealWithUI:0 isRecommend:YES];
        }];
    }
}

- (void)delete:(ArticleHomeItem *)item completion:(void(^)(BOOL success))completion{
    if (![item.articleSysNo isNotNull]) {
        [[iToast makeText:@"资讯编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    NSDictionary *parameters = @{@"relationSysNo":item.articleSysNo,
                                 @"likeType":@"2",
                                 @"isLike":@"0"};
    [TCProgressHUD showSVP];
    [Request startWithName:@"USER_LIKE_COLUMN" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}

@end
