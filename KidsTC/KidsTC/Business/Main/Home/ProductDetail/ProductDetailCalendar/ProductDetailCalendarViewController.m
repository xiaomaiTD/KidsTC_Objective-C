//
//  ProductDetailCalendarViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCalendarViewController.h"
#import <EventKit/EventKit.h>
#import "FSCalendar.h"
#import "FSCalendarHeader.h"

#import "NSDate+ZP.h"
#import "ZPDateFormate.h"
#import "NSString+ZP.h"
#import "UIBarButtonItem+Category.h"
#import "iToast.h"

@interface ProductDetailCalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (nonatomic, strong) FSCalendar *calendar;

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *titleDefaultColors;
@end

@implementation ProductDetailCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.times.count<1) {
        [[iToast makeText:@"时间为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"活动日期";
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO; // important
    calendar.allowsSelection = NO;
    calendar.allowsMultipleSelection = NO;
    calendar.focusOnSingleSelectedDate = NO;
    calendar.appearance.headerDateFormat = @"yyyy年MM月";
    calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
    calendar.appearance.weekdayTextColor = [UIColor blackColor];
    calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesDefaultCase;
    calendar.appearance.todayColor = [UIColor clearColor];
    calendar.appearance.titleTodayColor = [UIColor blackColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = DF_yMd;
    
    ProductDetailTimeItem *firstItem = self.times.firstObject;
    ProductDetailTimeItem *lastItem = self.times.lastObject;
    NSDate *minimumDate = [self.dateFormatter dateFromString:firstItem.startTime];
    NSDate *maximumDate = [self.dateFormatter dateFromString:lastItem.endTime];
    NSTimeInterval minNum = [minimumDate timeIntervalSince1970] - 30 * 24 * 60 * 60;
    NSTimeInterval maxNum = [maximumDate timeIntervalSince1970] + 30 * 24 * 60 * 60;
    self.minimumDate = [NSDate dateWithTimeIntervalSince1970:minNum];
    self.maximumDate = [NSDate dateWithTimeIntervalSince1970:maxNum];
    
    NSMutableDictionary *fillDefaultColors = [NSMutableDictionary dictionary];
    NSMutableDictionary *titleDefaultColors = [NSMutableDictionary dictionary];
    [_times enumerateObjectsUsingBlock:^(ProductDetailTimeItem *obj, NSUInteger idx, BOOL *stop) {
        
        NSDate *date_s = [NSDate zp_dateWithTimeString:obj.startTime withDateFormat:DF_yMd];
        NSTimeInterval timeInterval_s = [date_s timeIntervalSince1970];
        
        NSDate *date_e = [NSDate zp_dateWithTimeString:obj.endTime withDateFormat:DF_yMd];
        NSTimeInterval timeInterval_e = [date_e timeIntervalSince1970];
        
        while (timeInterval_s<=timeInterval_e) {
            NSString *timeStr = [NSString zp_stringWithTimeInterval:timeInterval_s Format:DF_yMd];
            [fillDefaultColors setObject:[COLOR_PINK colorWithAlphaComponent:0.8] forKey:timeStr];
            [titleDefaultColors setObject:[UIColor whiteColor] forKey:timeStr];
            timeInterval_s += 24*60*60;
        }
    }];
    self.fillDefaultColors = [NSDictionary dictionaryWithDictionary:fillDefaultColors];
    self.titleDefaultColors = [NSDictionary dictionaryWithDictionary:titleDefaultColors];
    
    self.naviTheme = NaviThemeWihte;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return self.maximumDate;
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar
                    appearance:(FSCalendarAppearance *)appearance
       fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar
                    appearance:(FSCalendarAppearance *)appearance
      titleDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter stringFromDate:date];
    if ([_titleDefaultColors.allKeys containsObject:key]) {
        return _titleDefaultColors[key];
    }
    return nil;
}

@end
