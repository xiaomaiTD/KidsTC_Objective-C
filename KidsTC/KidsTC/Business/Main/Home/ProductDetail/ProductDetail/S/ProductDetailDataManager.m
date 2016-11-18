//
//  ProductDetailDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailDataManager.h"

@implementation ProductDetailDataManager
singleM(ProductDetailDataManager)

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
            
        }
            break;
    }
    
}

- (void)loadRecommendSuccessBlock:(void(^)(NSArray<ProductDetailRecommendItem *> *recommends))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            [self loadNormalRecommendSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self loadTicketRecommendSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeFree:
        {
            
        }
            break;
    }
}

- (void)loadConsultSuccessBlock:(void(^)(NSArray<ProductDetailConsultItem *> *items))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock
{
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            [self loadNormalConsultSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self loadTicketConsultSuccessBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeFree:
        {
            
        }
            break;
    }
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

- (void)loadNormalRecommendSuccessBlock:(void(^)(NSArray<ProductDetailRecommendItem *> *recommends))successBlock
                           failureBlock:(void(^)(NSError *error))failureBlock
{
    NSDictionary *param = @{@"pid":_productId};
    [Request startWithName:@"GET_PRODUCT_RECOMMENDS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ProductDetailRecommendItem *> *recommends = [ProductDetailRecommendModel modelWithDictionary:dic].data;
        if (recommends.count>0) {
            if (successBlock) successBlock(recommends);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}

- (void)loadNormalConsultSuccessBlock:(void(^)(NSArray<ProductDetailConsultItem *> *items))successBlock
                         failureBlock:(void(^)(NSError *error))failureBlock
{
    NSDictionary *param = @{@"relationNo":_productId,
                            @"advisoryType":@"1",
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

- (void)loadTicketRecommendSuccessBlock:(void(^)(NSArray<ProductDetailRecommendItem *> *recommends))successBlock
                           failureBlock:(void(^)(NSError *error))failureBlock
{
    NSDictionary *param = @{@"pid":_productId};
    [Request startWithName:@"GET_PRODUCT_RECOMMENDS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ProductDetailRecommendItem *> *recommends = [ProductDetailRecommendModel modelWithDictionary:dic].data;
        if (recommends.count>0) {
            if (successBlock) successBlock(recommends);
        }else{
            if (failureBlock) failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) failureBlock(error);
    }];
}

- (void)loadTicketConsultSuccessBlock:(void(^)(NSArray<ProductDetailConsultItem *> *items))successBlock
                         failureBlock:(void(^)(NSError *error))failureBlock
{
    NSDictionary *param = @{@"relationNo":_productId,
                            @"advisoryType":@"1",
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

@end
