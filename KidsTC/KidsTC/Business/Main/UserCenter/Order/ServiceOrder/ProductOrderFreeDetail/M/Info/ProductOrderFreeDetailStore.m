//
//  ProductOrderFreeDetailStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailStore.h"
#import "NSString+Category.h"

@implementation ProductOrderFreeDetailStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _distance = [_distance isNotNull]?[NSString stringWithFormat:@"距离:%@",_distance]:nil;
    
    ProductDetailStore *addressStore = [[ProductDetailStore alloc] init];
    addressStore.level = _level;
    addressStore.imageUrl = _imageUrl;
    addressStore.phone = _phone;
    addressStore.distance = _distance;
    addressStore.storeId = _storeId;
    addressStore.storeName = _storeName;
    addressStore.address = _address;
    addressStore.mapAddress = _mapAddress;
    [addressStore setupStoreInfo];
    _addressStore = addressStore;
    
    return YES;
}
@end
