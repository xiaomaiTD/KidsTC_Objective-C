//
//  CollectProductCategoryViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"
#import "RecommendDataManager.h"

#import "CollectProductCategoryModel.h"
#import "CollectProductCategoryView.h"

@interface CollectProductCategoryViewController ()<CollectProductBaseViewDelegate>
@property (nonatomic, strong) CollectProductCategoryView *categoryView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectProductCategoryViewController

- (void)loadView {
    CollectProductCategoryView *categoryView = [[CollectProductCategoryView alloc] init];
    categoryView.delegate = self;
    self.view = categoryView;
    self.categoryView = categoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
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
    }
}

- (void)loadData:(BOOL)refresh {
    
    if (!self.categoryView.noMoreCollectData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"sort":@(CollectProductTypeCategory),
                                @"page":@(self.page),
                                @"pagecount":@(CollectProductPageCount)};
        [Request startWithName:@"GET_USER_INTEREST_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            CollectProductCategoryModel *model = [CollectProductCategoryModel modelWithDictionary:dic];
            if (refresh) {
                self.items = model.data;
            }else{
                NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
                [items addObjectsFromArray:model.data];
                self.items = [NSArray arrayWithArray:items];
            }
            self.categoryView.items = self.items;
            [self.categoryView dealWithUI:model.data.count isRecommend:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.categoryView dealWithUI:0 isRecommend:NO];
        }];
    }else {
        [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:RecommendProductTypeCollect refresh:refresh pageCount:TCPAGECOUNT productNos:nil successBlock:^(NSArray<RecommendProduct *> *data) {
            [self.categoryView dealWithUI:data.count isRecommend:YES];
        } failureBlock:^(NSError *error) {
            [self.categoryView dealWithUI:0 isRecommend:YES];
        }];
    }
}

@end
