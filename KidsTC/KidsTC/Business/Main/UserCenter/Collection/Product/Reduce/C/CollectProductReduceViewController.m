//
//  CollectProductReduceViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"
#import "NSString+Category.h"
#import "KTCFavouriteManager.h"

#import "CollectProductReduceModel.h"
#import "CollectProductReduceView.h"


@interface CollectProductReduceViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductReduceView *reduceView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectProductReduceViewController

- (void)loadView {
    CollectProductReduceView *reduceView = [[CollectProductReduceView alloc] init];
    reduceView.delegate = self;
    self.view = reduceView;
    self.reduceView = reduceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    self.reduceView.editing = editing;
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)collectProductBaseView:(CollectProductBaseView *)view actionType:(CollectProductBaseViewActionType)type value:(id)value completion:(void (^)(id))completion {
    switch (type) {
        case CollectProductBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        case CollectProductBaseViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case CollectProductBaseViewActionTypeDelete:
        {
            [self delete:value completion:^(BOOL success) {
                if (completion) completion(@(success));
            }];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"sort":@(CollectProductTypeReduct),
                            @"page":@(self.page),
                            @"pagecount":@(CollectProductPageCount)};
    [Request startWithName:@"GET_USER_INTEREST_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CollectProductReduceModel *model = [CollectProductReduceModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.reduceView.items = self.items;
        [self.reduceView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.reduceView dealWithUI:0];
    }];
}

- (void)delete:(NSString *)productId completion:(void(^)(BOOL success))completion{
    if (![productId isNotNull]) {
        [[iToast makeText:@"服务编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    [TCProgressHUD showSVP];
    [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:productId type:KTCFavouriteTypeService succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(YES);
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}

@end
