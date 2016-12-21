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

@interface RecommendDataManager : NSObject
singleH(RecommendDataManager)

- (void)loadRecommendProductType:(RecommendProductType)type
                         refresh:(BOOL)refresh
                       pageCount:(NSInteger)pageCount
                      productNos:(NSString *)productNos
                    successBlock:(void(^)(NSArray<RecommendProduct *> *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

- (void)loadRecommendStorePage:(NSInteger)page
                     pageCount:(NSInteger)pageCount
                  successBlock:(void(^)(NSDictionary *dic))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock;

- (void)loadRecommendContentPage:(NSInteger)page
                       pageCount:(NSInteger)pageCount
                    successBlock:(void(^)(NSDictionary *dic))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

- (void)loadRecommendTarentoPage:(NSInteger)page
                       pageCount:(NSInteger)pageCount
                    successBlock:(void(^)(NSDictionary *dic))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

- (BOOL)hasRecommendProductsWithType:(RecommendProductType)type;

- (NSArray<RecommendProduct *> *)recommendProductsWithType:(RecommendProductType)type;

- (void)nilRecommendProdWithType:(RecommendProductType)type;

@end
