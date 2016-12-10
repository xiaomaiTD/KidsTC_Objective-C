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
    
    return YES;
}
@end
