//
//  ProductDetailAddressSelStoreModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressSelStoreModel.h"
#import "ToolBox.h"

@implementation ProductDetailAddressSelStoreModel

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductDetailPlaceType:(PlaceType)placeType
                                                                           stores:(NSArray<ProductDetailStore *> *)stores
                                                                           places:(NSArray<ProductDetailPlace *> *)places
{
    switch (placeType) {
        case PlaceTypeStore:
        {
            NSMutableArray *models = [NSMutableArray array];
            [stores enumerateObjectsUsingBlock:^(ProductDetailStore * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
                model.name = obj.storeName;
                model.imageUrl = obj.imageUrl;
                model.level = obj.level;
                model.address = obj.address;
                model.mapAddress = obj.mapAddress;
                model.distance = obj.distance;
                //location
                CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
                model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
                NSString *storeAddress = model.address;
                if ([storeAddress isKindOfClass:[NSString class]]) {
                    [model.location setMoreDescription:storeAddress];
                }
                if(model) [models addObject:model];
            }];
            return models;
        }
            break;
        case PlaceTypePlace:
        {
            NSMutableArray *models = [NSMutableArray array];
            [places enumerateObjectsUsingBlock:^(ProductDetailPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
                model.name = obj.name;
                model.address = obj.address;
                model.mapAddress = obj.mapAddress;
                model.distance = obj.distance;
                //location
                CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
                model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
                NSString *storeAddress = model.address;
                if ([storeAddress isKindOfClass:[NSString class]]) {
                    [model.location setMoreDescription:storeAddress];
                }
                if(model) [models addObject:model];
            }];
            return models;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductOrderTicketDetailData:(ProductOrderTicketDetailData *)data {
    NSMutableArray *models = [NSMutableArray array];
    ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
    model.name = data.theater;
    model.address = data.address;
    model.mapAddress = data.mapAddress;
    //location
    CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
    NSString *storeAddress = model.address;
    if ([storeAddress isKindOfClass:[NSString class]]) {
        [model.location setMoreDescription:storeAddress];
    }
    if(model) [models addObject:model];
    return models;
}

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductOrderFreeDetailStore:(ProductOrderFreeDetailStore *)store {
    NSMutableArray *models = [NSMutableArray array];
    ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
    model.name = store.storeName;
    model.imageUrl = store.imageUrl;
    model.level = store.level;
    model.address = store.address;
    model.mapAddress = store.mapAddress;
    model.distance = store.distance;
    //location
    CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
    NSString *storeAddress = model.address;
    if ([storeAddress isKindOfClass:[NSString class]]) {
        [model.location setMoreDescription:storeAddress];
    }
    if(model) [models addObject:model];
    return models;
}

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithProductDetailData:(ProductDetailData *)data {
    NSMutableArray *models = [NSMutableArray array];
    ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
    model.name = data.theater.theaterName;
    model.address = data.theater.address;
    model.mapAddress = data.theater.mapAddress;
    //location
    CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
    NSString *storeAddress = model.address;
    if ([storeAddress isKindOfClass:[NSString class]]) {
        [model.location setMoreDescription:storeAddress];
    }
    if(model) [models addObject:model];
    return models;
}

+(NSArray<ProductDetailAddressSelStoreModel *> *)modelsWithWolesaleProductDetailPlaceType:(PlaceType)placeType
                                                                                   stores:(NSArray<WholesaleProductDetailStoreItem *> *)stores
                                                                                   places:(NSArray<WolesaleProductDetailPlace *> *)places
{
    switch (placeType) {
        case PlaceTypeStore:
        {
            NSMutableArray *models = [NSMutableArray array];
            [stores enumerateObjectsUsingBlock:^(WholesaleProductDetailStoreItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
                model.name = obj.storeName;
                model.imageUrl = obj.imageUrl;
                model.level = obj.level;
                model.address = obj.address;
                model.mapAddress = obj.mapAddress;
                model.distance = obj.distance;
                //location
                CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
                model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
                NSString *storeAddress = model.address;
                if ([storeAddress isKindOfClass:[NSString class]]) {
                    [model.location setMoreDescription:storeAddress];
                }
                if(model) [models addObject:model];
            }];
            return models;
        }
            break;
        case PlaceTypePlace:
        {
            NSMutableArray *models = [NSMutableArray array];
            [places enumerateObjectsUsingBlock:^(WolesaleProductDetailPlace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductDetailAddressSelStoreModel *model = [ProductDetailAddressSelStoreModel new];
                model.name = obj.name;
                model.address = obj.address;
                model.mapAddress = obj.mapAddress;
                model.distance = obj.distance;
                //location
                CLLocationCoordinate2D coord = [ToolBox coordinateFromString:model.mapAddress];
                CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
                model.location = [[KTCLocation alloc] initWithLocation:loc locationDescription:model.name];
                NSString *storeAddress = model.address;
                if ([storeAddress isKindOfClass:[NSString class]]) {
                    [model.location setMoreDescription:storeAddress];
                }
                if(model) [models addObject:model];
            }];
            return models;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}
@end
