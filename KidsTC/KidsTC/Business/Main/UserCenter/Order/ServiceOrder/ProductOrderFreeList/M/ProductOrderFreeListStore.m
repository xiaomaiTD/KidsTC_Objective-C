//
//  ProductOrderFreeListStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListStore.h"
#import "NSString+Category.h"

@implementation ProductOrderFreeListStore
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _distance = [_distance isNotNull]?[NSString stringWithFormat:@"距离:%@",_distance]:nil;
    
    return YES;
}
@end
