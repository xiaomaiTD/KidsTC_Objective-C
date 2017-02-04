//
//  WholesaleSettlementTime.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/19.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesaleSettlementTime.h"
#import "NSString+Category.h"

@implementation WholesaleSettlementTime
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (![_timeDesc isNotNull]) _timeDesc = @"";
    
    return YES;
}
@end
