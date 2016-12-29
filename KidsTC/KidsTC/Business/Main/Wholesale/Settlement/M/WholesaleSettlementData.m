//
//  WholesaleSettlementData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementData.h"


@implementation WholesaleSettlementData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"place" : [WholesaleSettlementPlace class],
             @"stores":[WholesaleSettlementStore class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self setupShareObj:dic];
    [self setupPlaces];
    [self setupStoreItems];
    return YES;
}
- (void)setupShareObj:(NSDictionary *)data {
    self.shareObject = [CommonShareObject shareObjectWithRawData:[data objectForKey:@"share"]];
    if (self.shareObject) {
        self.shareObject.identifier = _productNo;
        self.shareObject.followingContent = @"【童成】";
    }
}
- (void)setupPlaces {
    NSMutableArray *ary = [NSMutableArray array];
    [_place enumerateObjectsUsingBlock:^(WholesaleSettlementPlace *obj, NSUInteger idx, BOOL *stop) {
        ServiceSettlementPlace *place = [ServiceSettlementPlace placeWith:obj];
        if (place) [ary addObject:place];
    }];
    self.places = [NSArray arrayWithArray:ary];
}
- (void)setupStoreItems {
    NSMutableArray *ary = [NSMutableArray array];
    [_stores enumerateObjectsUsingBlock:^(WholesaleSettlementStore *obj, NSUInteger idx, BOOL *stop) {
        
        SettlementPickStoreDataItem *store = [SettlementPickStoreDataItem new];
        store.storeId = obj.storeId;
        store.storeName = obj.storeName;
        store.level = obj.level;
        store.distance = obj.distance;
        store.phone = obj.phone;
        store.imgUrl = obj.imageUrl;
        store.mapAddress = obj.mapAddress;
        [store modelCustomTransformFromDictionary:nil];
        
        if (store) [ary addObject:store];
    }];
    self.storeItems = [NSArray arrayWithArray:ary];
}
@end
