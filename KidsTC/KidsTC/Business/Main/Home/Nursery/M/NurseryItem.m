//
//  NurseryItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryItem.h"
#import "NSString+Category.h"
#import "ToolBox.h"

@implementation NurseryItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"pictures" : [NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableString *routeStr = [NSMutableString string];
    if ([_drivingTimeDesc isNotNull]) {
        [routeStr appendString:_drivingTimeDesc];
    }
    if ([_ridingTimeDesc isNotNull]) {
        [routeStr appendString:_ridingTimeDesc];
    }
    if ([_walkingTimeDesc isNotNull]) {
        [routeStr appendString:_walkingTimeDesc];
    }
    _routeStr = [NSString stringWithString:routeStr];
    
    if ([_mapAddress isNotNull]) {
        _coordinate2D = [ToolBox coordinateFromString:_mapAddress];
    }
    return YES;
}
@end
