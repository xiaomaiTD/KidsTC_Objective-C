
//
//  ProductOrderNormalDetailStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailStore.h"
#import "NSString+Category.h"

@implementation ProductOrderNormalDetailStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_storeNo isNotNull]) {
        _segueModel = [SegueModel modelWithDestination:SegueDestinationStoreDetail paramRawData:@{@"sid":_storeNo}];
    }
    
    return YES;
}
@end
