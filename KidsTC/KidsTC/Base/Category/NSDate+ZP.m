//
//  NSDate+ZP.m
//  ZPCategory
//
//  Created by zhanping on 4/6/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "NSDate+ZP.h"

@implementation NSDate (ZP)

#pragma mark - 获取（根据指定时间）：年、月、日、时、分、秒

#pragma mark 年
+ (NSUInteger)getYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
    return [dayComponents year];
}

#pragma mark 月
+ (NSUInteger)getMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    return [dayComponents month];
}

#pragma mark 日
+ (NSUInteger)getDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
    return [dayComponents day];
}

#pragma mark 时
+ (NSInteger )getHour:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [components hour];
    return hour;
}

#pragma mark 分
+ (NSInteger)getMinute:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components minute];
    return minute;
}

#pragma mark 秒
+ (NSInteger)getSecond:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components second];
    return minute;
}

#pragma mark 周
+ (NSInteger)getWeak:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger weak = [components weekday];
    return weak;
}

#pragma mark - 获取（根据对象时间）：年、月、日、时、分、秒

#pragma mark 年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}

#pragma mark 月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}

#pragma mark 日
- (NSUInteger)getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}

#pragma mark 时
- (NSInteger )getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return hour;
}

#pragma mark 分
- (NSInteger)getMinute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return minute;
}

#pragma mark 秒
- (NSInteger)getSecond {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components second];
    return minute;
}

#pragma mark 周
- (NSInteger)getWeak {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger weak = [components weekday];
    return weak;
}


#pragma mark - 时间戳 转化成 时间
+(instancetype)zp_dateWithTimeNumber:(NSNumber *)timeNumber{
    if (timeNumber==nil) {
        return nil;
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",timeNumber];
    //[str deleteCharactersInRange:NSMakeRange(str.length-4, 4)];
    NSTimeInterval time=[str doubleValue];
    str=nil;
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:time];
    
    return date;
}
#pragma mark - 时间字符串 转化成 时间
+(instancetype)zp_dateWithTimeString:(NSString *)timeString withDateFormat:(NSString *)dateFormat{
    
    if (timeString==nil||[timeString isEqualToString:@""]) {
        return nil;
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:dateFormat];
    NSDate *date = [inputFormatter dateFromString:timeString];
    inputFormatter=nil;
    return date;
}
@end
