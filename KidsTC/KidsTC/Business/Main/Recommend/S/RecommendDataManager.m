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

#pragma mark - product

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

#pragma mark - store

@property (nonatomic, strong) NSArray<RecommendStore *> *recommendStoreCollectStoreData;
@property (nonatomic, assign) NSInteger collectStorePage;

#pragma mark - content

@property (nonatomic, strong) NSArray<ArticleHomeItem *> *recommendContentCollectContentData;
@property (nonatomic, assign) NSInteger collectContentPage;

#pragma mark - tarento

@property (nonatomic, strong) NSArray<RecommendTarento *> *recommendTarentoCollectTarentoData;
@property (nonatomic, assign) NSInteger collectTarentoPage;

@end

@implementation RecommendDataManager
singleM(RecommendDataManager)

#pragma mark - product

- (void)loadRecommendProductType:(RecommendProductType)type
                         refresh:(BOOL)refresh
                       pageCount:(NSInteger)pageCount
                      productNos:(NSString *)productNos
                    successBlock:(void(^)(NSArray<RecommendProduct *> *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock
{
    NSInteger page = [self recommendProductWithType:type refresh:refresh];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(type) forKey:@"type"];
    [param setObject:@(page) forKey:@"pageIndex"];
    [param setObject:@(pageCount) forKey:@"pageSize"];
    if ([productNos isNotNull]) {
        [param setObject:productNos forKey:@"productNos"];
    }
    [Request startWithName:@"GET_RECOMMEND_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<RecommendProduct *> *data = [RecommendProductModel modelWithDictionary:dic].data;
        [self dealWithRecommendProductData:data type:type refresh:refresh];
        if(successBlock)successBlock(data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (NSInteger)recommendProductWithType:(RecommendProductType)type refresh:(BOOL)refresh {
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

- (void)dealWithRecommendProductData:(NSArray<RecommendProduct *> *)data type:(RecommendProductType)type refresh:(BOOL)refresh {
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


#pragma mark - store


- (void)loadRecommendStoreRefresh:(BOOL)refresh
                        pageCount:(NSInteger)pageCount
                     successBlock:(void(^)(NSArray<RecommendStore *> *data))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock
{
    self.collectStorePage = refresh?1:++self.collectStorePage;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(self.collectStorePage) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"GET_RECOMMEND_STORE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<RecommendStore *> *data = [RecommendStoreModel modelWithDictionary:dic].data;
        if (refresh) {
            self.recommendStoreCollectStoreData = [NSArray arrayWithArray:data];
        }else{
            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendStoreCollectStoreData];
            [ary addObjectsFromArray:data];
            self.recommendStoreCollectStoreData = [NSArray arrayWithArray:ary];
        }
        if(successBlock)successBlock(data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (BOOL)hasRecommendStore {
    return self.recommendStore.count>0;
}

- (NSArray<RecommendStore *> *)recommendStore{
    return self.recommendStoreCollectStoreData;
}

- (void)nilRecommendStore {
    self.recommendStoreCollectStoreData = nil;
    self.collectStorePage = 1;
}


#pragma mark - content


- (void)loadRecommendContentRefresh:(BOOL)refresh
                          pageCount:(NSInteger)pageCount
                       successBlock:(void(^)(NSArray<ArticleHomeItem *> *data))successBlock
                       failureBlock:(void(^)(NSError *error))failureBlock
{
    self.collectContentPage = refresh?1:(++self.collectContentPage);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(self.collectContentPage) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"RECOMMEND_ARTICLE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ArticleHomeItem *> *data = [RecommendContentModel modelWithDictionary:dic].data;
        if (refresh) {
            self.recommendContentCollectContentData = [NSArray arrayWithArray:data];
        }else{
            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendContentCollectContentData];
            [ary addObjectsFromArray:data];
            self.recommendContentCollectContentData = [NSArray arrayWithArray:ary];
        }
        if(successBlock)successBlock(data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (BOOL)hasRecommendContent {
    return self.recommendContent.count>0;
}

- (NSArray<ArticleHomeItem *> *)recommendContent {
    return self.recommendContentCollectContentData;
}

- (void)nilRecommendContent {
    self.recommendContentCollectContentData = nil;
    self.collectContentPage = 1;
}

#pragma mark - tarento


- (void)loadRecommendTarentoRefresh:(BOOL)refresh
                          pageCount:(NSInteger)pageCount
                       successBlock:(void(^)(NSArray<RecommendTarento *> *data))successBlock
                       failureBlock:(void(^)(NSError *error))failureBlock
{
    self.collectTarentoPage = refresh?1:(++self.collectTarentoPage);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(self.collectTarentoPage) forKey:@"page"];
    [param setObject:@(pageCount) forKey:@"pageCount"];
    [Request startWithName:@"RECOMMEND_ARTICLE_AUTHOR" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<RecommendTarento *> *data = [RecommendTarentoModel modelWithDictionary:dic].data;
        if (refresh) {
            self.recommendTarentoCollectTarentoData = [NSArray arrayWithArray:data];
        }else{
            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendTarentoCollectTarentoData];
            [ary addObjectsFromArray:data];
            self.recommendTarentoCollectTarentoData = [NSArray arrayWithArray:ary];
        }
        if(successBlock)successBlock(data);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failureBlock)failureBlock(error);
    }];
}

- (BOOL)hasRecommendTarento {
    return self.recommendTarento.count>0;
}

- (NSArray<id> *)recommendTarento {
    return self.recommendTarentoCollectTarentoData;
}

- (void)nilRecommendTarento {
    self.recommendTarentoCollectTarentoData = nil;
    self.collectTarentoPage = 1;
}

@end
