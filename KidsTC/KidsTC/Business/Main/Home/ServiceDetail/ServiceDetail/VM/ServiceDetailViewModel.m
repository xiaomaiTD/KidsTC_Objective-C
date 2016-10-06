//
//  ServiceDetailViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/15/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ServiceDetailViewModel.h"
#import "KTCFavouriteManager.h"
#import "GHeader.h"
#import "ToolBox.h"
#import "KTCMapService.h"
@interface ServiceDetailViewModel () <ServiceDetailViewDataSource>

@property (nonatomic, weak) ServiceDetailView *view;

@end

@implementation ServiceDetailViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (ServiceDetailView *)view;
        self.view.dataSource = self;
        _detailModel = [[ServiceDetailModel alloc] init];
    }
    return self;
}

#pragma mark ServiceDetailViewDataSource

- (ServiceDetailModel *)detailModelForServiceDetailView:(ServiceDetailView *)detailView {
    return self.detailModel;
}

#pragma mark Private methods

- (BOOL)loadDetailSucceed:(NSDictionary *)data {
    BOOL fillData = [self.detailModel fillWithRawData:[data objectForKey:@"data"]];
    return fillData;
}

- (void)loadDetailFailed:(NSError *)error {
    _detailModel = nil;
}

- (void)loadIntroduction {
    
    [self.view setIntroductionUrlString:self.detailModel.introductionUrlString];
//    if (!self.loadIntroductionRequest) {
//        self.loadIntroductionRequest = [HttpRequestClient clientWithUrlAliasName:@"PRODUCT_GET_DESC"];
//    }
//    __weak ServiceDetailViewModel *weakSelf = self;
//    [weakSelf.loadIntroductionRequest startHttpRequestWithParameter:[NSDictionary dictionaryWithObject:self.detailModel.serviceId forKey:@"pid"] success:^(HttpRequestClient *client, NSDictionary *responseData) {
//        [weakSelf loadIntroductionSucceed:responseData];
//    } failure:^(HttpRequestClient *client, NSError *error) {
//        [weakSelf loadIntroductionFailed:error];
//    }];
}

- (void)loadIntroductionSucceed:(NSDictionary *)data {
    NSString *htmlString = [data objectForKey:@"data"];
    if ([htmlString isKindOfClass:[NSString class]]) {
        if ([htmlString length] > 0) {
        }
    }
}

- (void)loadIntroductionFailed:(NSError *)error {
    
}

#pragma mark Public methods

- (void)startUpdateDataWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId Succeed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    if ([serviceId length] == 0) {
        return;
    }
    if ([channelId length] == 0) {
        channelId = @"0";
    }
    [self.detailModel setServiceId:serviceId];
    [self.detailModel setChannelId:channelId];
    NSString *coordinateString = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:serviceId, @"pid", channelId, @"chid", coordinateString, @"mapaddr", nil];
    [Request startWithName:@"PRODUCT_GETDETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if ([self loadDetailSucceed:dic]) {
            if (succeed) succeed(dic);
        } else {
            NSError *error = [NSError errorWithDomain:@"Service Detail" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"没有查询到数据" forKey:kErrMsgKey]];
            [self loadDetailFailed:error];
            if (failure) failure(error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDetailFailed:error];
        if (failure) failure(error);
    }];
}


- (void)addToSettlementWithBuyCount:(NSUInteger)count storeId:(NSString *)storeId succeed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    if ([storeId length] == 0) {
        storeId = @"0";
    }
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:self.detailModel.serviceId, @"productid", self.detailModel.channelId, @"chid", storeId, @"storeno", [NSNumber numberWithInteger:count], @"buynum", nil];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}


- (void)addOrRemoveFavouriteWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    NSString *identifier = self.detailModel.serviceId;
    KTCFavouriteType type = KTCFavouriteTypeService;
    __weak ServiceDetailViewModel *weakSelf = self;
    if (self.detailModel.isFavourate) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *data) {
            [weakSelf.detailModel setIsFavourate:NO];
            if (succeed) {
                succeed(data);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *data) {
            [weakSelf.detailModel setIsFavourate:YES];
            if (succeed) {
                succeed(data);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}



- (void)resetMoreInfoViewWithViewTag:(ServiceDetailMoreInfoViewTag)viewTag {
    if (viewTag == ServiceDetailMoreInfoViewTagIntroduction) {
        [self loadIntroduction];
    }
}

#pragma mark Super methods

- (void)stopUpdateData {
    
}


@end
