//
//  NSString+ZP.h
//  ZPCategory
//
//  Created by zhanping on 4/6/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZP)

#pragma mark 字典转JSON
+(NSString *)zp_stringWithDictory:(NSDictionary *)dic;
#pragma mark NSDate 转换成Str
+(instancetype)zp_stringWithDate:(NSDate *)date Format:(NSString *)format;
#pragma mark NSNumber 转换成Str
+(instancetype)zp_stringWithTimeIntervalNumber:(NSNumber *)timeIntervalNumber Format:(NSString *)format;
#pragma mark NSTimeInterval 转换成Str
+(instancetype)zp_stringWithTimeInterval:(NSTimeInterval)timeInterval Format:(NSString *)format;

#pragma mark appPath
+(instancetype)zp_appPath;
#pragma mark document路径
+(instancetype)zp_documentPath;
+(instancetype)zp_documentPathByAppendingPathComponent:(NSString *)fileName;

#pragma mark app的版本号
+ (NSString *)zp_appVersionString;

#pragma mark md5 16位 加密 （小写）
+(instancetype)zp_md5:(NSString *)str;


@end
