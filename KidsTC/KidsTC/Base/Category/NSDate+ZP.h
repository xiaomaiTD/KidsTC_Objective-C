//
//  NSDate+ZP.h
//  ZPCategory
//
//  Created by zhanping on 4/6/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPDateFormate.h"

@interface NSDate (ZP)

#pragma mark - 获取（根据指定时间）：年、月、日、时、分、秒

#pragma mark 年
+ (NSUInteger)getYear:(NSDate *)date;

#pragma mark 月
+ (NSUInteger)getMonth:(NSDate *)date;

#pragma mark 日
+ (NSUInteger)getDay:(NSDate *)date;

#pragma mark 时
+ (NSInteger )getHour:(NSDate *)date ;

#pragma mark 分
+ (NSInteger)getMinute:(NSDate *)date;

#pragma mark 秒
+ (NSInteger)getSecond:(NSDate *)date;

#pragma mark 周
+ (NSInteger)getWeak:(NSDate *)date;

#pragma mark - 获取（根据对象时间）：年、月、日、时、分、秒

#pragma mark 年
- (NSUInteger)getYear;

#pragma mark 月
- (NSUInteger)getMonth;

#pragma mark 日
- (NSUInteger)getDay;

#pragma mark 时
- (NSInteger )getHour;

#pragma mark 分
- (NSInteger)getMinute;

#pragma mark 秒
- (NSInteger)getSecond;

#pragma mark 周
- (NSInteger)getWeak;


#pragma mark - 时间戳 转化成 时间
+(instancetype)zp_dateWithTimeNumber:(NSNumber *)timeNumber;
#pragma mark - 字符串 转化成 时间
+(instancetype)zp_dateWithTimeString:(NSString *)timeString withDateFormat:(NSString *)dateFormat;
@end
