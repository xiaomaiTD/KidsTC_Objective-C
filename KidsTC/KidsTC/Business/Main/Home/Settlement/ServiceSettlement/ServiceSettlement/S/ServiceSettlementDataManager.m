//
//  ServiceSettlementDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementDataManager.h"
#import "GHeader.h"
#import "NSString+Category.h"

@implementation ServiceSettlementDataManager

- (void)loadDataWithParam:(NSDictionary *)param
             successBlock:(void(^)(ServiceSettlementModel *model))successBlock
             failureBlock:(void(^)(NSError *error))failureBlock
{
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            [self loadDataNormalWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self loadDataTicketWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeFree:
        {
            [self loadDataFreeWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
    }
}

- (void)loadDataNormalWithParam:(NSDictionary *)param
                   successBlock:(void(^)(ServiceSettlementModel *model))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock
{
    [Request startWithName:@"SHOPPINGCART_GET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ServiceSettlementModel *model = [ServiceSettlementModel modelWithDictionary:dic];
        if (model.data) {
            if(successBlock)successBlock(model);
        }else{
            if(failureBlock)failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)loadDataTicketWithParam:(NSDictionary *)param
                   successBlock:(void(^)(ServiceSettlementModel *model))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock
{
    [Request startWithName:@"GET_TICKET_PRODUCT_CONFIRM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ServiceSettlementModel *model = [ServiceSettlementModel modelWithDictionary:dic];
        if (model.data) {
            if(successBlock)successBlock(model);
        }else{
            if(failureBlock)failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)loadDataFreeWithParam:(NSDictionary *)param
                 successBlock:(void(^)(ServiceSettlementModel *model))successBlock
                 failureBlock:(void(^)(NSError *error))failureBlock
{
    
}

- (void)placeOrderWithParam:(NSDictionary *)param
               successBlock:(void(^)(PayModel *model))successBlock
               failureBlock:(void(^)(NSError *error))failureBlock
{
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            [self placeOrderNormalWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeTicket:
        {
            [self placeOrderTicketWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        case ProductDetailTypeFree:
        {
            [self placeOrderFreeWithParam:param successBlock:successBlock failureBlock:failureBlock];
        }
            break;
            default:
            break;
    }
}

- (void)placeOrderNormalWithParam:(NSDictionary *)param
                     successBlock:(void(^)(PayModel *model))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    [Request startWithName:@"ORDER_PLACE_ORDER_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        PayModel *model = [PayModel modelWithDictionary:dic];
        if ([model.data.orderNo isNotNull]) {
            if(successBlock)successBlock(model);
        }else{
            if(failureBlock)failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)placeOrderTicketWithParam:(NSDictionary *)param
                     successBlock:(void(^)(PayModel *model))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    [Request startWithName:@"TICKET_PRODUCT_PLACE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        PayModel *model = [PayModel modelWithDictionary:dic];
        if ([model.data.orderNo isNotNull]) {
            if(successBlock)successBlock(model);
        }else{
            if(failureBlock)failureBlock(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)placeOrderFreeWithParam:(NSDictionary *)param
                   successBlock:(void(^)(PayModel *model))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock
{
    
}

@end
