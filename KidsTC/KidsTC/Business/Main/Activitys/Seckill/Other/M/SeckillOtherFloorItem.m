//
//  SeckillOtherFloorItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherFloorItem.h"

@implementation SeckillOtherFloorItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"contents":[SeckillOtherContent class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_ratio<=0) {
        _ratio = 0.6;
    }
    if (_contents.count>0) {
        _content = _contents.firstObject;
    }
    return YES;
}
@end
