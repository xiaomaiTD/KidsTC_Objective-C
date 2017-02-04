//
//  WholesaleProductDetailCountDown.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailCountDown.h"

@implementation WholesaleProductDetailCountDown
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
    int unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = nil;
    if (components.day>0){
        time = [NSString stringWithFormat:@"%.2zd天%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        time = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        time = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _countDownValueString = [NSString stringWithFormat:@"%@",time];
    _countDownTime--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}
@end
