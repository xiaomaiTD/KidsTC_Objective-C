//
//  RecommendDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"

#import "RecommendProductModel.h"
#import "RecommendStoreModel.h"
#import "RecommendContentModel.h"
#import "RecommendTarentoModel.h"

@interface RecommendDataManager : NSObject
singleH(RecommendDataManager)

#pragma mark - product

- (void)loadRecommendProductType:(RecommendProductType)type
                         refresh:(BOOL)refresh
                       pageCount:(NSInteger)pageCount
                      productNos:(NSString *)productNos
                    successBlock:(void(^)(NSArray<RecommendProduct *> *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

- (BOOL)hasRecommendProductsWithType:(RecommendProductType)type;

- (NSArray<RecommendProduct *> *)recommendProductsWithType:(RecommendProductType)type;

- (void)nilRecommendProdWithType:(RecommendProductType)type;

#pragma mark - store

- (void)loadRecommendStoreRefresh:(BOOL)refresh
                        pageCount:(NSInteger)pageCount
                     successBlock:(void(^)(NSArray<RecommendStore *> *data))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock;

- (BOOL)hasRecommendStore;

- (NSArray<RecommendStore *> *)recommendStore;

- (void)nilRecommendStore;

#pragma mark - content

- (void)loadRecommendContentRefresh:(BOOL)refresh
                          pageCount:(NSInteger)pageCount
                       successBlock:(void(^)(NSArray<ArticleHomeItem *> *data))successBlock
                       failureBlock:(void(^)(NSError *error))failureBlock;

- (BOOL)hasRecommendContent;

- (NSArray<ArticleHomeItem *> *)recommendContent;

- (void)nilRecommendContent;

#pragma mark - tarento

- (void)loadRecommendTarentoRefresh:(BOOL)refresh
                          pageCount:(NSInteger)pageCount
                       successBlock:(void(^)(NSArray<RecommendTarento *> *data))successBlock
                       failureBlock:(void(^)(NSError *error))failureBlock;

- (BOOL)hasRecommendTarento;

- (NSArray<RecommendTarento *> *)recommendTarento;

- (void)nilRecommendTarento;



@end
