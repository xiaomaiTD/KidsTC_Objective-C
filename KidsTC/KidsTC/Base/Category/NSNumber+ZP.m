//
//  NSNumber+ZP.m
//  ZPCategory
//
//  Created by zhanping on 4/6/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "NSNumber+ZP.h"

@implementation NSNumber (ZP)
+(instancetype)numberWithDate:(NSDate *)date{
    NSNumber *number = [NSNumber numberWithLongLong:[date timeIntervalSince1970]];
    return number;
}

+(instancetype)numberWithString:(NSString *)string{
    
    long long i=[string longLongValue];
    
    return [NSNumber numberWithLongLong:i];
}
@end
