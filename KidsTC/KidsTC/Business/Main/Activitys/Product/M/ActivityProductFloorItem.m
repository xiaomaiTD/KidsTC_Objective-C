//
//  ActivityProductFloorItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductFloorItem.h"

@implementation ActivityProductFloorItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"contents":[ActivityProductContent class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_marginTop<=0) _marginTop = CGFLOAT_MIN;
    if (_ratio<=0) _ratio = 0.6;
    return YES;
}
@end
