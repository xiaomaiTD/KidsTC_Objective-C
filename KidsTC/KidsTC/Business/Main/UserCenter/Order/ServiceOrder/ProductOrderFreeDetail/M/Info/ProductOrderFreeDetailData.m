//
//  ProductOrderFreeDetailData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailData.h"
#import "NSString+Category.h"

@implementation ProductOrderFreeDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"orderBtns":[NSNumber class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_ageStr isNotNull]) {
        _ageStr = [NSString stringWithFormat:@"适应：%@",_ageStr];
    }else _ageStr = nil;
    if ([_productSysNo isNotNull]) {
        if (![_channelId isNotNull]) {
            _channelId = @"0";
        }
        NSDictionary *params = @{@"pid":_productSysNo,
                                 @"icd":_channelId,
                                 @"type":@(ProductDetailTypeFree)};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:params];
    }
    
    
    [self setupMoblies];
    
    if (_isShowCountDown) {
        [self setupCountDownValueString];
        [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
    }
    [self setupBtns];
    return YES;
}

- (void)setupBtns {
    NSMutableArray *btns = [NSMutableArray array];
    int count = (int)_orderBtns.count;
    for (int i = 1; i<=4; i++) {
        int index = count - i;
        if (index>=0) {
            NSNumber *obj = _orderBtns[index];
            ProductOrderFreeDetailBtnType btnType = obj.integerValue;
            ProductOrderFreeDetailBtn *btn = [ProductOrderFreeDetailBtn btnWithType:btnType isHighLight:btnType == _defaultBtn];
            if (btn) [btns addObject:btn];
        }
    }
    _btns = [NSArray arrayWithArray:btns];
}

- (void)setupMoblies {
    NSString *phonesString =  _storeInfo.phone;
    if ([phonesString isNotNull]) {
        NSMutableArray *phonesAry = [NSMutableArray new];
        if ([phonesString containsString:@";"]) {
            NSArray *ary = [phonesString componentsSeparatedByString:@";"];
            for (NSString *str in ary) {
                if (str && ![str isEqualToString:@""]) {
                    [phonesAry addObject:str];
                }
            }
        }else{
            if (phonesString && ![phonesString isEqualToString:@""]) {
                [phonesAry addObject:phonesString];
            }
        }
        _supplierPhones = [NSArray arrayWithArray:phonesAry];
    }
}

- (void)countDown{
    if (_countDownValue<0) {
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
    _countDownValueString = [NSString stringWithFormat:@"%@%@",@"",time];
    _countDownValue--;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}
@end
