//
//  ActivityProductContent.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductContent.h"

@implementation ActivityProductContent
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tabItems":[ActivityProductTabItem class],
             @"couponModels":[ActivityProductCoupon class],
             @"productItems":[ActivityProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    [self setupCoupons];
    
    [self setupCountDown];
    
    return YES;
}

- (void)setupCoupons {
    if (self.couponModels.count>4) {
        NSRange range = NSMakeRange(0, 4);
        self.couponModels = [self.couponModels subarrayWithRange:range];
    }
}

- (void)setupCountDown {
    if (_isShowCountDown&&_countDownValue>0) {
        [self setupCountDownValueString];
        [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    }
}

- (void)countDown{
    if (_countDownValue<0) {
        _countDownValueString = nil;
        _daysLeft = nil;
        _hoursLeft = nil;
        _minuteLeft = nil;
        _secondLeft = nil;
        
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
    }else{
        [self  setupCountDownValueString];
    }
}

- (void)setupCountDownValueString {
    if (_countDownValue<0){
        _countDownValueString = nil;
        return;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_countDownValue];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = nil;
    if (components.day>0){
        _daysLeft = [NSString stringWithFormat:@"%zd",components.day];
        time = [NSString stringWithFormat:@"%zd天%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        time = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        time = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        time = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _countDownValueString = [NSString stringWithFormat:@"%@%@",_countDownText,time];
    
    if (components.day<1) _daysLeft = nil;
    
    _hoursLeft = [NSString stringWithFormat:@"%.2zd",components.hour];
    
    _minuteLeft = [NSString stringWithFormat:@"%.2zd",components.minute];
    
    _secondLeft = [NSString stringWithFormat:@"%.2zd",components.second];
    
    _countDownValue--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}
@end
