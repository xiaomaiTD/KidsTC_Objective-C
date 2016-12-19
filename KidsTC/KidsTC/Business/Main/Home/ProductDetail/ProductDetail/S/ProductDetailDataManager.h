//
//  ProductDetailDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "GHeader.h"
#import "ProductDetailModel.h"
#import "ProductDetailRecommendModel.h"
#import "ProductDetailConsultModel.h"

@interface ProductDetailDataManager : NSObject

@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;

- (void)loadDataWithSuccessBlock:(void(^)(ProductDetailData *data))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

- (void)loadRecommendSuccessBlock:(void(^)(NSArray<ProductDetailRecommendItem *> *recommends))successBlock
                     failureBlock:(void(^)(NSError *error))failureBlock;

- (void)loadConsultSuccessBlock:(void(^)(NSArray<ProductDetailConsultItem *> *items))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock;

@end
