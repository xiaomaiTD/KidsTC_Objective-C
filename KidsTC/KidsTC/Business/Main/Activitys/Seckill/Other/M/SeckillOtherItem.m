//
//  SeckillOtherItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherItem.h"

@implementation SeckillOtherItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"floorItems":[SeckillOtherFloorItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableArray *ary = [NSMutableArray array];
    [_floorItems enumerateObjectsUsingBlock:^(SeckillOtherFloorItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.contentType == 1 && obj.contents.count>0) {
            [ary addObject:obj];
        }
    }];
    self.items = [NSArray arrayWithArray:ary];
    return YES;
}
@end
