//
//  NSString+Category.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "NSString+Category.h"
#import "UIDevice+IdentifierAddition.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation NSString (Category)

#pragma mark 校验用户手机号码
+(BOOL)validateMobile:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    return NO;
}
#pragma mark 校验用户密码（密码6-20位数字和字母组合）
+ (BOOL)validatePassword:(NSString *)password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

+ (NSString *)generateSMSCodeKey {
    NSString *deviceId = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSTimeInterval timeStamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *codeKey = [NSString stringWithFormat:@"%@%f", deviceId, timeStamp];
    return codeKey;
}

+ (UIColor *)colorWithString:(NSString *)string {
    if (!string || ![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSArray *colorArray = [string componentsSeparatedByString:@","];
    if ([colorArray count] < 3) {
        return nil;
    }
    UIColor *color = [UIColor colorWithRed:[[colorArray objectAtIndex:0] floatValue]/255.0 green:[[colorArray objectAtIndex:1] floatValue]/255.0 blue:[[colorArray objectAtIndex:2] floatValue]/255.0 alpha:1];
    return color;
}


+ (NSArray<NSString *> *)rangeStringsOfSubString:(NSString *)sub inString:(NSString *)string {
    if (![sub isKindOfClass:[NSString class]] || ![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    if ([sub length] == 0 || [string length] == 0) {
        return nil;
    }
    NSString *copyStr = string;
    NSMutableString *replaceString = [[NSMutableString alloc] init];
    for (NSUInteger index = 0; index < [sub length]; index ++) {
        [replaceString appendString:@"x"];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    while ([copyStr rangeOfString:sub].location != NSNotFound) {
        NSRange  range  = [copyStr rangeOfString:sub];
        if (range.location != NSNotFound) {
            [tempArray addObject:NSStringFromRange(range)];
        }
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:replaceString];
    }
    if ([tempArray count] > 0) {
        return [NSArray arrayWithArray:tempArray];
    }
    return nil;
}

- (BOOL)isNotNull{
    return (self &&
            [self isKindOfClass:[NSString class]] &&
            self.length>0 &&
            ![@"null" isEqualToString:self] &&
            ![@"(null)" isEqualToString:self] &&
            ![@"<null>" isEqualToString:self]);
}

#pragma mark 最多两位小数的价格字符串
+ (NSString *)priceStr:(CGFloat)price{
    NSString *priceStr = @"";
    if (fmodf(price, 1)==0) {
        priceStr = [NSString stringWithFormat:@"%.0f",price];
    } else if (fmodf(price*10, 1)==0) {
        priceStr = [NSString stringWithFormat:@"%.1f",price];
    } else {
        priceStr = [NSString stringWithFormat:@"%.2f",price];
    }
    return priceStr;
}

//必须在有网的情况下才能获取手机的IP地址
+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    NSLog(@"手机的IP是：%@", address);
    
    if (![address isNotNull]) {
        address = @"";
    }
    
    return address;
}

@end
