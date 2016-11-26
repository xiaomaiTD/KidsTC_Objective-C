//
//  CollectionStoreItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreItem.h"
#import "NSString+Category.h"

@implementation CollectionStoreItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"couponModeLst":[CollectionStoreCoupon class],
             @"productLst":[CollectionStoreProduct class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_storeNo isNotNull]) {
        _segueModel = [SegueModel modelWithDestination:SegueDestinationStoreDetail paramRawData:@{@"sid":_storeNo}];
    }
    
    return YES;
}
@end
