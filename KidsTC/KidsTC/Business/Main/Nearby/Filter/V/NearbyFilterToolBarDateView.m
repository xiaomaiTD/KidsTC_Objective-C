//
//  NearbyFilterToolBarDateView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterToolBarDateView.h"
#import <EventKit/EventKit.h>
#import "FSCalendar.h"
#import "FSCalendarHeader.h"

@interface NearbyFilterToolBarDateView ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (nonatomic, strong) FSCalendar *calendar;
@end

@implementation NearbyFilterToolBarDateView

- (FSCalendar *)calendar {
    if (!_calendar) {
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        calendar.dataSource = self;
        calendar.delegate = self;
        calendar.pagingEnabled = NO; // important
        calendar.allowsSelection = YES;
        calendar.allowsMultipleSelection = NO;
        calendar.focusOnSingleSelectedDate = NO;
        calendar.appearance.headerDateFormat = @"yyyy年MM月";
        calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
        calendar.appearance.weekdayTextColor = [UIColor blackColor];
        calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
        calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesDefaultCase;
        [self addSubview:calendar];
        _calendar = calendar;
    }
    return _calendar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.calendar.frame = self.bounds;
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    if ([self.delegate respondsToSelector:@selector(nearbyFilterToolBarDateView:didSelectDate:)]) {
        [self.delegate nearbyFilterToolBarDateView:self didSelectDate:date];
    }
}



@end
