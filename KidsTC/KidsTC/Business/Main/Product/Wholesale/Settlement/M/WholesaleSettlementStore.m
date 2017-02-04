//
//  WholesaleSettlementStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementStore.h"
#import "NSString+Category.h"

@implementation WholesaleSettlementStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_storeId isNotNull]) {
        _storeId = [NSString stringWithFormat:@"%@",dic[@"storeNo"]];
    }
    return YES;
}
+ (instancetype)storeWithObj:(SettlementPickStoreDataItem *)obj{
    WholesaleSettlementStore *store = [WholesaleSettlementStore new];
    store.level = obj.level;
    store.imageUrl = obj.imgUrl;
    store.phone = obj.phone;
    store.distance = obj.distance;
    store.storeId = obj.storeId;
    store.storeName = obj.storeName;
    store.address = obj.address;
    store.mapAddress = obj.mapAddress;
    return store;
}
@end
