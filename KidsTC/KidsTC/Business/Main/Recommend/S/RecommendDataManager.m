//
//  RecommendDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendDataManager.h"
#import "NSString+Category.h"

@interface RecommendDataManager ()
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductAccountCenterData;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductCollectProductData;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductOrderListData;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductTicketProductData;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductNormalProductData;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommendProductFreeProductData;

@property (nonatomic, assign) NSInteger accountCenterPage;
@property (nonatomic, assign) NSInteger collectProductPage;
@property (nonatomic, assign) NSInteger orderListPage;
@property (nonatomic, assign) NSInteger ticketProductPage;
@property (nonatomic, assign) NSInteger normalProductPage;
@property (nonatomic, assign) NSInteger freeProductPage;
@end

@implementation RecommendDataManager
singleM(RecommendDataManager)

- (void)loadRecommendProductType:(RecommendProductType)type
                         refresh:(BOOL)refresh
                       pageCount:(NSInteger)pageCount
                      productNos:(NSString *)productNos
                    successBlock:(void(^)(NSArray<RecommendProduct *> *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock
{
    NSInteger page = [self pageWithType:type refresh:refresh];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(type) forKey:@"type"];
    [param setObject:@(page) forKey:@"pageIndex"];
    [param setObject:@(pageCount) forKey:@"pageSize"];
    if ([productNos isNotNull]) {
        [param setObject:productNos forKey:@"productNos"];
    }
    [Request startWithName:@"GET_RECOMMEND_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<RecommendProduct *> *data = [RecommendProductModel modelWithDictionary:dic].data;
        [self dealWithData:data type:type refresh:refresh];
        if(successBlock)successBlock(data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (NSInteger)pageWithType:(RecommendProductType)type refresh:(BOOL)refresh {
    switch (type) {
        case RecommendProductTypeUserCenter:
        {
            self.accountCenterPage = refresh?1:++self.accountCenterPage;
            return self.accountCenterPage;
        }
            break;
        case RecommendProductTypeCollect:
        {
            self.collectProductPage = refresh?1:++self.collectProductPage;
            return self.collectProductPage;
        }
            break;
        case RecommendProductTypeOrderList:
        {
            self.orderListPage = refresh?1:++self.orderListPage;
            return self.orderListPage;
        }
            break;
        case RecommendProductTypeTicket:
        {
            self.ticketProductPage = refresh?1:++self.ticketProductPage;
            return self.ticketProductPage;
        }
            break;
        case RecommendProductTypeNormal:
        {
            self.normalProductPage = refresh?1:++self.normalProductPage;
            return self.normalProductPage;
        }
            break;
        case RecommendProductTypeFree:
        {
            self.freeProductPage = refresh?1:++self.freeProductPage;
            return self.freeProductPage;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
}

- (void)dealWithData:(NSArray<RecommendProduct *> *)data type:(RecommendProductType)type refresh:(BOOL)refresh {
    switch (type) {
        case RecommendProductTypeUserCenter:
        {
            if (refresh) {
                self.recommendProductAccountCenterData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductAccountCenterData];
                [ary addObjectsFromArray:data];
                self.recommendProductAccountCenterData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        case RecommendProductTypeCollect:
        {
            if (refresh) {
                self.recommendProductCollectProductData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductCollectProductData];
                [ary addObjectsFromArray:data];
                self.recommendProductCollectProductData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        case RecommendProductTypeOrderList:
        {
            if (refresh) {
                self.recommendProductOrderListData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductOrderListData];
                [ary addObjectsFromArray:data];
                self.recommendProductOrderListData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        case RecommendProductTypeTicket:
        {
            if (refresh) {
                self.recommendProductTicketProductData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductTicketProductData];
                [ary addObjectsFromArray:data];
                self.recommendProductTicketProductData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        case RecommendProductTypeNormal:
        {
            if (refresh) {
                self.recommendProductNormalProductData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductNormalProductData];
                [ary addObjectsFromArray:data];
                self.recommendProductNormalProductData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        case RecommendProductTypeFree:
        {
            if (refresh) {
                self.recommendProductFreeProductData = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendProductFreeProductData];
                [ary addObjectsFromArray:data];
                self.recommendProductFreeProductData = [NSArray arrayWithArray:ary];
            }
        }
            break;
        default:
        {
            
        }
            break;
    }
}

- (void)loadRecommendStorePage:(NSInteger)page
                     pageCount:(NSInteger)pageCount
                  successBlock:(void(^)(NSDictionary *dic))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(page) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"GET_RECOMMEND_STORE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(successBlock)successBlock(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)loadRecommendContentPage:(NSInteger)page
                       pageCount:(NSInteger)pageCount
                    successBlock:(void(^)(NSDictionary *dic))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(page) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"RECOMMEND_ARTICLE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(successBlock)successBlock(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (void)loadRecommendTarentoPage:(NSInteger)page
                       pageCount:(NSInteger)pageCount
                    successBlock:(void(^)(NSDictionary *dic))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(page) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"RECOMMEND_ARTICLE_AUTHOR" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(successBlock)successBlock(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (BOOL)hasRecommendProductsWithType:(RecommendProductType)type {
    return [self recommendProductsWithType:type].count>0;
    
}

- (NSArray<RecommendProduct *> *)recommendProductsWithType:(RecommendProductType)type {
    switch (type) {
        case RecommendProductTypeUserCenter:
        {
            return self.recommendProductAccountCenterData;
        }
            break;
        case RecommendProductTypeCollect:
        {
            return self.recommendProductCollectProductData;
        }
            break;
        case RecommendProductTypeOrderList:
        {
            return self.recommendProductOrderListData;
        }
            break;
        case RecommendProductTypeTicket:
        {
            return self.recommendProductTicketProductData;
        }
            break;
        case RecommendProductTypeNormal:
        {
            return self.recommendProductNormalProductData;
        }
            break;
        case RecommendProductTypeFree:
        {
            return self.recommendProductFreeProductData;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

- (void)nilRecommendProdWithType:(RecommendProductType)type {
    switch (type) {
        case RecommendProductTypeUserCenter:
        {
            self.recommendProductAccountCenterData = nil;
            self.accountCenterPage = 1;
        }
            break;
        case RecommendProductTypeCollect:
        {
            self.recommendProductCollectProductData = nil;
            self.collectProductPage = 1;
        }
            break;
        case RecommendProductTypeOrderList:
        {
            self.recommendProductOrderListData = nil;
            self.orderListPage = 1;
        }
            break;
        case RecommendProductTypeTicket:
        {
            self.recommendProductTicketProductData = nil;
            self.ticketProductPage = 1;
        }
            break;
        case RecommendProductTypeNormal:
        {
            self.recommendProductNormalProductData = nil;
            self.normalProductPage = 1;
        }
            break;
        case RecommendProductTypeFree:
        {
            self.recommendProductFreeProductData = nil;
            self.freeProductPage = 1;
        }
            break;
        default:
        {
            
        }
            break;
    }
}

@end
