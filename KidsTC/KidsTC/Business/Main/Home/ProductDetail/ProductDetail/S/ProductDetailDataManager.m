//
//  ProductDetailDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailDataManager.h"
#import "KTCMapService.h"
#import "RecommendDataManager.h"

@implementation ProductDetailDataManager

- (void)loadDataWithSuccessBlock:(void(^)(ProductDetailData *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock
{
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            [self loadNormalProductDataSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self loadTicketProductDataSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeFree:
        {
            [self loadFreeProductDataSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
            default:
            break;
    }
}

- (void)loadRecommendSuccessBlock:(void(^)(NSArray<RecommendProduct *> *recommends))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    RecommendProductType recommendType = RecommendProductTypeNormal;
    switch (_type) {
        case ProductDetailTypeTicket:
        {
            recommendType = RecommendProductTypeTicket;
        }
            break;
        case ProductDetailTypeFree:
        {
            recommendType = RecommendProductTypeFree;
        }
            break;
        case ProductDetailTypeRadish:
        {
            recommendType = RecommendProductTypeRadish;
        }
            break;
        default:
        {
            recommendType = RecommendProductTypeNormal;
        }
            break;
    }
    [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:recommendType refresh:YES pageCount:TCPAGECOUNT productNos:_productId successBlock:^(NSArray<RecommendProduct *> *data) {
        if(successBlock)successBlock(data);
    } failureBlock:^(NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)loadConsultSuccessBlock:(void(^)(NSArray<ProductDetailConsultItem *> *items))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock
{
    NSDictionary *param = @{@"relationNo":_productId,
                            @"advisoryType":@(_type),
                            @"pageIndex":@(1),
                            @"pageSize":@(20)};
    [Request startWithName:@"GET_ADVISORY_ADN_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ProductDetailConsultItem *> *items = [ProductDetailConsultModel modelWithDictionary:dic].items;
        if (items.count>0) {
            if (successBlock) successBlock(items);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}


#pragma mark - normal

- (void)loadNormalProductDataSuccessBlock:(void(^)(ProductDetailData *data))successBlock
                            failureBlock:(void(^)(NSError *error))failureBlock
{
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"mapaddr":location};
    [Request startWithName:@"PRODUCT_GETDETAIL_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailData *data = [ProductDetailModel modelWithDictionary:dic].data;
        if (data) {
            if (successBlock) successBlock(data);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}


#pragma mark - ticket

- (void)loadTicketProductDataSuccessBlock:(void(^)(ProductDetailData *data))successBlock
                             failureBlock:(void(^)(NSError *error))failureBlock
{
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"mapaddr":location};
    [Request startWithName:@"GET_PRODUCT_TICKET" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailData *data = [ProductDetailModel modelWithDictionary:dic].data;
        if (data) {
            if (successBlock) successBlock(data);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}


#pragma mark - free

- (void)loadFreeProductDataSuccessBlock:(void(^)(ProductDetailData *data))successBlock
                           failureBlock:(void(^)(NSError *error))failureBlock
{
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"mapaddr":location};
    [Request startWithName:@"GET_FREE_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailData *data = [ProductDetailModel modelWithDictionary:dic].data;
        if (data) {
            if (successBlock) successBlock(data);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}


@end
