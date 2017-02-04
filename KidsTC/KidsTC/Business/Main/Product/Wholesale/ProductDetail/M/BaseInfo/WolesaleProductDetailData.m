//
//  WolesaleProductDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailData.h"

@implementation WolesaleProductDetailData
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupSku];
    
    return YES;
}

- (void)setupSku {
    self.sku.type = WholesalePickDateSKUBtnTypeBuy;
    switch (self.fightGroupBase.placeType) {
        case PlaceTypeStore:
        {
            NSMutableArray *ary = [NSMutableArray array];
            [self.fightGroupBase.stores enumerateObjectsUsingBlock:^(WholesaleProductDetailStoreItem *obj, NSUInteger idx, BOOL *stop) {
                WholesalePickDatePlace *place = [[WholesalePickDatePlace alloc] init];
                place.ID = obj.storeId;
                place.name = obj.storeName;
                place.address = obj.address;
                if (place) [ary addObject:place];
            }];
            self.sku.places = [NSArray arrayWithArray:ary];
        }
            break;
        case PlaceTypePlace:
        {
            NSMutableArray *ary = [NSMutableArray array];
            [self.fightGroupBase.place enumerateObjectsUsingBlock:^(WolesaleProductDetailPlace *obj, NSUInteger idx, BOOL *stop) {
                WholesalePickDatePlace *place = [[WholesalePickDatePlace alloc] init];
                place.ID = obj.sysNo;
                place.name = obj.name;
                place.address = obj.address;
                if (place) [ary addObject:place];
            }];
            self.sku.places = [NSArray arrayWithArray:ary];
        }
            break;
        default:
            break;
    }
    if (self.sku.places.count>0) {
        self.sku.places.firstObject.select = YES;
    }
}

@end
