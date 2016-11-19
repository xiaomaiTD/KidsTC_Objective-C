//
//  NSString+ZP.m
//  ZPCategory
//
//  Created by zhanping on 4/6/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "NSString+ZP.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZP)

#pragma mark 转JSON
+(NSString *)zp_stringWithJsonObj:(id)jsonObj{
    if (jsonObj == nil) {
        return nil;
    }
    NSError *err;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:&err];
    if(err) {
        NSLog(@"转JSON失败：%@",err);
        return nil;
    }
    NSString *jsonString_utf8=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString_utf8;
}

#pragma mark 时间转换成Str
+(instancetype)zp_stringWithDate:(NSDate *)date Format:(NSString *)format{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:date];
    
    return timestamp_str;
}

#pragma mark 时间戳转换成Str
+(instancetype)zp_stringWithTimeIntervalNumber:(NSNumber *)timeIntervalNumber Format:(NSString *)format{
    
    return [self zp_stringWithTimeInterval:[timeIntervalNumber longLongValue] Format:format];
}

+(instancetype)zp_stringWithTimeInterval:(NSTimeInterval)timeInterval Format:(NSString *)format {
    if (timeInterval<0) {
        return nil;
    }
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:date];
    outputFormatter=nil;
    
    return timestamp_str;
}



#pragma mark appPath
+(instancetype)zp_appPath;
{
    return [[NSBundle mainBundle]resourcePath];
}

#pragma mark document路径
+(instancetype)zp_documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
}

+(instancetype)zp_documentPathByAppendingPathComponent:(NSString *)fileName{
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:fileName];
}

#pragma mark app的版本号
+ (NSString *)zp_appVersionString
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return version;
}

#pragma mark md5 16位 加密 （小写）
+(instancetype)zp_md5:(NSString *)str{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    //需要#import <CommonCrypto/CommonDigest.h>
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    //    //输出2  简化版
    //    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    //
    //    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
    //        [ret appendFormat:@"%02X",result];
    //    }
    //    return ret;
}


@end
