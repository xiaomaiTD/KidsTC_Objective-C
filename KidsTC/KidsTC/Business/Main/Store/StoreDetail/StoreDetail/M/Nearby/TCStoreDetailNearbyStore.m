//
//  TCStoreDetailNearbyStore.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyStore.h"
#import "NSString+Category.h"

@implementation TCStoreDetailNearbyStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_storeId isNotNull]) {
        _segueModel = [SegueModel modelWithDestination:SegueDestinationStoreDetail paramRawData:@{@"sid":_storeId}];
    }
    
    return YES;
}
@end
