//
//  CollectionStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "KTCFavouriteManager.h"
#import "RecommendDataManager.h"

#import "CollectionStoreModel.h"
#import "CollectionStoreView.h"

@interface CollectionStoreViewController ()<CollectionSCTBaseViewDelegate>
@property (nonatomic, strong) CollectionStoreView *storeView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CollectionStoreViewController

- (void)loadView {
    CollectionStoreView *storeView = [[CollectionStoreView alloc] init];
    storeView.delegate = self;
    self.view  = storeView;
    self.storeView = storeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    self.storeView.editing = editing;
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
        case CollectionSCTBaseViewActionTypeCollect:
        {
            [self collect:value];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    if (!self.storeView.noMoreListData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"page":@(self.page),
                                @"pagecount":@(CollectionSCTPageCount)};
        [Request startWithName:@"GET_USER_INTEREST_STORE_LST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            CollectionStoreModel *model = [CollectionStoreModel modelWithDictionary:dic];
            if (refresh) {
                self.items = model.data;
            }else{
                NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
                [items addObjectsFromArray:model.data];
                self.items = [NSArray arrayWithArray:items];
            }
            self.storeView.items = self.items;
            [self.storeView dealWithUI:model.data.count isRecommend:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.storeView dealWithUI:0 isRecommend:NO];
        }];
    }else{
        [[RecommendDataManager shareRecommendDataManager] loadRecommendStoreRefresh:refresh pageCount:5 successBlock:^(NSArray<RecommendStore *> *data) {
            [self.storeView dealWithUI:data.count isRecommend:YES];
        } failureBlock:^(NSError *error) {
            [self.storeView dealWithUI:0 isRecommend:YES];
        }];
    }
}

- (void)delete:(CollectionStoreItem *)item completion:(void(^)(BOOL success))completion{
    if (![item.storeNo isNotNull]) {
        [[iToast makeText:@"服务编号为空"] show];
        if (completion) completion(NO);
        return;
    }
    [TCProgressHUD showSVP];
    [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:item.storeNo type:KTCFavouriteTypeStore succeed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(YES);
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        if (completion) completion(NO);
    }];
}

- (void)collect:(id)value {
    if (![value isKindOfClass:[RecommendStore class]]) {
        return;
    }
    RecommendStore *store = value;
    if (store.isInterest) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:store.storeNo type:KTCFavouriteTypeStore succeed:nil failure:nil];
    }else{
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:store.storeNo type:KTCFavouriteTypeStore succeed:nil failure:nil];
    }
}

@end
