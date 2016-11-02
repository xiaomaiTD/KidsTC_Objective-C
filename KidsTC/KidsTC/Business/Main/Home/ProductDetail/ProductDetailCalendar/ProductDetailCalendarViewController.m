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
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = DF_yMd;
    
    ProductDetailTimeItem *firstItem = self.times.firstObject;
    ProductDetailTimeItem *lastItem = self.times.lastObject;
    self.minimumDate = [self.dateFormatter dateFromString:firstItem.startTime];
    self.maximumDate = [self.dateFormatter dateFromString:lastItem.endTime];
    
    NSMutableDictionary *fillDefaultColors = [NSMutableDictionary dictionary];
    NSMutableDictionary *titleDefaultColors = [NSMutableDictionary dictionary];
    [_times enumerateObjectsUsingBlock:^(ProductDetailTimeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
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
    
    [self setupWhiteStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [self addNaviShadow];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeNaviShadow];
}

- (void)setupWhiteStyle {
    
    self.naviColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(back) andGetButton:^(UIButton *btn) {
        btn.bounds = CGRectMake(0, 0,18, 18);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    }];
}

- (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = self.navigationController.navigationBar;
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)setupBarButtonItemTheme
{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        [obj setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        [obj setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    }];
    
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        [obj setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        [obj setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    }];
}

- (void)addNaviShadow {
    CALayer *layer = self.navigationController.navigationBar.layer;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    layer.shadowOffset = CGSizeMake(0, 4);
    layer.shadowRadius = 2;
    layer.shadowOpacity = 0.5;
}

- (void)removeNaviShadow {
    CALayer *layer = self.navigationController.navigationBar.layer;
    layer.shadowColor = [UIColor clearColor].CGColor;
    layer.shadowOffset = CGSizeZero;
    layer.shadowRadius = 0;
    layer.shadowOpacity = 0;
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
