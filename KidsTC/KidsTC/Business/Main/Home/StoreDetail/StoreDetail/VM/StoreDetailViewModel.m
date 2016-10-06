//
//  StoreDetailViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/17/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "StoreDetailViewModel.h"
#import "KTCFavouriteManager.h"
#import "GHeader.h"
#import "KTCMapService.h"

@interface StoreDetailViewModel () <StoreDetailViewDataSource>

@property (nonatomic, weak) StoreDetailView *view;

- (void)loadDetailSucceed:(NSDictionary *)data;

- (void)loadDetailFailed:(NSError *)error;

@end

@implementation StoreDetailViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (StoreDetailView *)view;
        self.view.dataSource = self;
        _detailModel = [[StoreDetailModel alloc] init];
    }
    return self;
}

#pragma mark ServiceDetailViewDataSource


- (StoreDetailModel *)detailModelForStoreDetailView:(StoreDetailView *)detailView {
    return self.detailModel;
}


#pragma mark Private methods

- (void)loadDetailSucceed:(NSDictionary *)data {
    if (![self.detailModel fillWithRawData:[data objectForKey:@"data"]]) {
        _detailModel = nil;
    }
    [self.view reloadData];
}

- (void)loadDetailFailed:(NSError *)error {
    _detailModel = nil;
    [self.view reloadData];
}

#pragma mark Public methods

- (void)startUpdateDataWithStoreId:(NSString *)storeId succeed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    if ([storeId length] == 0) {
        return;
    }
    [self.detailModel setStoreId:storeId];

    NSString *coordinateString = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:storeId, @"storeId", coordinateString, @"mapaddr", nil];
    
    [Request startWithName:@"STORE_GETDETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDetailSucceed:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDetailFailed:error];
        if (failure) failure(error);
    }];
}


- (void)addOrRemoveFavouriteWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    NSString *identifier = self.detailModel.storeId;
    KTCFavouriteType type = KTCFavouriteTypeStore;
    __weak StoreDetailViewModel *weakSelf = self;
    if (self.detailModel.isFavourate) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *data) {
            [weakSelf.detailModel setIsFavourate:NO];
            if (succeed) succeed(data);
        } failure:^(NSError *error) {
            if (failure) failure(error);
        }];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *data) {
            [weakSelf.detailModel setIsFavourate:YES];
            if (succeed) succeed(data);
        } failure:^(NSError *error) {
            if (failure) failure(error);
        }];
    }
}

@end
