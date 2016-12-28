//
//  ProductDetailAddressSelStoreModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTCMapService.h"
#import "ProductDetailStore.h"
#import "ProductDetailPlace.h"
#import "ProductOrderFreeDetailStore.h"
#import "ProductOrderTicketDetailData.h"
#import "ProductDetailData.h"
#import "WolesaleProductDetailPlace.h"
#import "WholesaleProductDetailStoreItem.h"

@interface ProductDetailAddressSelStoreModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) KTCLocation *location;

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductDetailPlaceType:(PlaceType)placeType
                                                                           stores:(NSArray<ProductDetailStore *> *)stores
                                                                           places:(NSArray<ProductDetailPlace *> *)places;

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductOrderTicketDetailData:(ProductOrderTicketDetailData *)data;

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductOrderFreeDetailStore:(ProductOrderFreeDetailStore *)store;

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductDetailData:(ProductDetailData *)data;

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithWolesaleProductDetailPlaceType:(PlaceType)placeType
                                                                                   stores:(NSArray<WholesaleProductDetailStoreItem *> *)stores
                                                                                   places:(NSArray<WolesaleProductDetailPlace *> *)places;

@end
