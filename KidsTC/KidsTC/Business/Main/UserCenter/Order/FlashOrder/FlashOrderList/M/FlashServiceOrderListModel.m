//
//  FlashServiceOrderListModel.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderListModel.h"
#import "FlashServiceOrderListViewController.h"

@implementation FlashServiceOrderListItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"priceConfigs" : [FlashServiceOrderDetailPriceConfig class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _countDownValueOriginal = _countDownValue;
    
    if (_priceConfigs.count>0) {
        [_priceConfigs enumerateObjectsUsingBlock:^(FlashServiceOrderDetailPriceConfig *obj, NSUInteger idx, BOOL *stop) {
            if (idx==0) {
                _currentPriceConfig = obj;
            }else{
                if (obj.priceStatus == FDPriceStatus_CurrentAchieved) _currentPriceConfig = obj;
            }
        }];
    }
    if (_isShowCountDown) {
        [self setupCountDownValueString];
        [NotificationCenter addObserver:self selector:@selector(countDown) name:FlashServiceOrderListCellCountDownNoti object:nil];
    }
    return YES;
}

- (void)countDown{
    if (_countDownValue<0) {
        [NotificationCenter removeObserver:self name:FlashServiceOrderListCellCountDownNoti object:nil];
    }else{
        [self  setupCountDownValueString];
    }
}

- (void)setupCountDownValueString {
    
    if (_countDownValue<0){
        _countDownValueString = nil;
        return;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:self.countDownValue];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    NSString *time = @"";
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
    _countDownValueString = [NSString stringWithFormat:@"%@:%@",self.countDownStr,time];
    _countDownValue--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:FlashServiceOrderListCellCountDownNoti object:nil];
}

@end

@implementation FlashServiceOrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [FlashServiceOrderListItem class]};
}
@end
