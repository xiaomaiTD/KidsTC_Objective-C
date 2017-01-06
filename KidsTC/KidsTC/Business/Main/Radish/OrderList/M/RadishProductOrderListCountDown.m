//
//  RadishProductOrderListCountDown.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListCountDown.h"



@implementation RadishProductOrderListCountDown

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_showCountDown) {
        [self setupCountDownValueString];
        [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    }
    return YES;
}

- (void)countDown{
    if (_countDownTime<0) {
        _countDownValueString = nil;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
    }else{
        [self  setupCountDownValueString];
    }
}

- (void)setupCountDownValueString {
    if (_countDownTime<0){
        _countDownValueString = nil;
        return;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_countDownTime];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = nil;
    if (components.year>0) {
        time = [NSString stringWithFormat:@"%.2zd年%.2zd月%.2zd天%.2zd时%.2zd分%.2zd秒",components.year,components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.month>0){
        time = [NSString stringWithFormat:@"%.2zd月%.2zd天%.2zd时%.2zd分%.2zd秒",components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.day>0){
        time = [NSString stringWithFormat:@"%.2zd天%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        time = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        time = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _countDownValueString = [NSString stringWithFormat:@"%@%@",_countDownDesc,time];
    _countDownTime--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}
@end
