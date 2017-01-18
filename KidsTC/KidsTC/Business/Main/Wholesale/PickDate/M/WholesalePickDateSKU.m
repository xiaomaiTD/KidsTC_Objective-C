//
//  WholesalePickDateSKU.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateSKU.h"

@implementation WholesalePickDateSKU
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"times" : [WholesalePickDateTime class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (self.times.count>0) {
        __block BOOL has = NO;
        [_times enumerateObjectsUsingBlock:^(WholesalePickDateTime *obj, NSUInteger idx, BOOL *stop) {
            if (obj.select) {
                has = YES;
                *stop = YES;
            }
        }];
        if (!has) self.times.firstObject.select = YES;
    }
    
    return YES;
}
@end
