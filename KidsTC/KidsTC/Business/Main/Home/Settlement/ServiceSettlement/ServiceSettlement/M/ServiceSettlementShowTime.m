//
//  ServiceSettlementShowTime.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementShowTime.h"
#import "NSString+Category.h"

@implementation ServiceSettlementShowTime
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [self setupShowStr];
    
    return YES;
}

- (void)setupShowStr {
    
    NSMutableString *showStr = [NSMutableString string];
    if ([_date isNotNull]) {
        [showStr appendString:_date];
    }
    if ([_dayOfWeek isNotNull]) {
        [showStr appendFormat:@" %@",_dayOfWeek];
    }
    if ([_minuteTime isNotNull]) {
        [showStr appendFormat:@" %@",_minuteTime];
    }
    _showStr = [NSString stringWithString:showStr];
}
@end
