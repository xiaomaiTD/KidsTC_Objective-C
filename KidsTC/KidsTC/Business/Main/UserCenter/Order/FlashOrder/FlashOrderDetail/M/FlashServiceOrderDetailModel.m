//
//  FlashServiceOrderDetailModel.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailModel.h"
#import "NSString+Category.h"

@implementation FlashServiceOrderDetailRefund

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableAttributedString *refundDescAttStr = [[NSMutableAttributedString alloc]init];
    
    if ([_consume_codes isNotNull]) {
        NSString *codesStr = [NSString stringWithFormat:@"%@消费编码：%@",refundDescAttStr.length>0?@"\n":@"",_consume_codes];
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:codesStr];
        [refundDescAttStr appendAttributedString:timeAttStr];
    }
    
    if ([_refund_apply_time isNotNull]) {
        NSString *timeStr = [NSString stringWithFormat:@"%@申请时间：%@",refundDescAttStr.length>0?@"\n":@"",_refund_apply_time];
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:timeStr];
        [refundDescAttStr appendAttributedString:timeAttStr];
    }
    
    if ([_refund_status_desc isNotNull]) {
        NSString *statusStr = [NSString stringWithFormat:@"%@退款状态：%@",refundDescAttStr.length>0?@"\n":@"",_refund_status_desc];
        NSAttributedString *statusAttStr = [[NSAttributedString alloc]initWithString:statusStr];
        [refundDescAttStr appendAttributedString:statusAttStr];
    }
    
    NSString *moneyStr = [NSString stringWithFormat:@"%@退款金额：¥%0.1f",refundDescAttStr.length>0?@"\n":@"",_refund_money];
    NSAttributedString *moneyAttStr = [[NSAttributedString alloc]initWithString:moneyStr];
    [refundDescAttStr appendAttributedString:moneyAttStr];
    
    NSString *scoreStr = [NSString stringWithFormat:@"%@退款积分：¥%zd",refundDescAttStr.length>0?@"\n":@"",_refund_score];
    NSAttributedString *scoreAttStr = [[NSAttributedString alloc]initWithString:scoreStr];
    [refundDescAttStr appendAttributedString:scoreAttStr];
    
    if (refundDescAttStr.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 8;
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                              NSForegroundColorAttributeName:[UIColor darkGrayColor],
                              NSParagraphStyleAttributeName:paragraph};
        [refundDescAttStr addAttributes:att range:NSMakeRange(0, refundDescAttStr.length)];
    }
    
    if (_refund_notice.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 6;
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                              NSForegroundColorAttributeName:COLOR_PINK_FLASH,
                              NSParagraphStyleAttributeName:paragraph};
        NSString *noticeStr = [NSString stringWithFormat:@"%@%@",refundDescAttStr.length>0?@"\n":@"",_refund_notice];
        NSAttributedString *noticeAttStr = [[NSAttributedString alloc]initWithString:noticeStr attributes:att];
        [refundDescAttStr appendAttributedString:noticeAttStr];
    }
    
    _refundDescStr = refundDescAttStr;
    
    return YES;
}


@end

@implementation FlashServiceOrderDetailPriceConfig

@end

@implementation FlashServiceOrderDetailUserAddress

@end

@implementation FlashServiceOrderDetailRemark

@end

@implementation FlashServiceOrderDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"refunds" : [FlashServiceOrderDetailRefund class],
             @"priceConfigs" : [FlashServiceOrderDetailPriceConfig class],
             @"remarks":[FlashServiceOrderDetailRemark class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _countDownValueOriginal = _countDownValue;
    
    switch (_onlineBespeakStatus) {
        case OrderBookingBespeakStatusCanBespeak:
        case OrderBookingBespeakStatusBespeaking:
        case OrderBookingBespeakStatusBespeakFail:
        case OrderBookingBespeakStatusBespeakSuccess:
        case OrderBookingBespeakStatusCancle:
        {
            _canShowButton = YES;
        }
            break;
        default:
        {
            _canShowButton = NO;
        }
            break;
    }
    
    if ([_supplierPhone isNotNull]) {
        NSArray *array = [_supplierPhone componentsSeparatedByString:@";"];
        _supplierPhones = array;
    }

    
    if (self.remarks.count>0) {
        __block NSMutableAttributedString *remaksAttStr = [[NSMutableAttributedString alloc]init];
        [self.remarks enumerateObjectsUsingBlock:^(FlashServiceOrderDetailRemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.remark isNotNull]) {
                NSString *remarkStr = [NSString stringWithFormat:@"%@%@",idx==0?@"":@"\n",obj.remark];
                NSAttributedString *remarkAttStr = [[NSAttributedString alloc]initWithString:remarkStr];
                [remaksAttStr appendAttributedString:remarkAttStr];
            }
        }];
        if (remaksAttStr.length>0) {
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
            paragraph.lineSpacing = 8;
            NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                  NSParagraphStyleAttributeName:paragraph};
            [remaksAttStr addAttributes:att range:NSMakeRange(0, remaksAttStr.length)];
            _remarksStr = remaksAttStr;
        }
    }
    
    NSMutableAttributedString *orderInfoAttStr = [[NSMutableAttributedString alloc]init];
    
//    NSAttributedString *oderIdAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单编号：%@",_orderId]];
//    [orderInfoAttStr appendAttributedString:oderIdAttStr];
    
    if ([_orderStatusDesc isNotNull]) {
        NSAttributedString *orderStatusDescAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单状态：%@",_orderStatusDesc]];
        [orderInfoAttStr appendAttributedString:orderStatusDescAttStr];
    }
    if ([_joinTime isNotNull]) {
        NSAttributedString *joinTimeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@购买时间：%@",orderInfoAttStr.length>0?@"\n":@"",_joinTime]];
        [orderInfoAttStr appendAttributedString:joinTimeAttStr];
    }
    
    NSAttributedString *prepaidMoneyAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@预付金额：¥%0.1f",orderInfoAttStr.length>0?@"\n":@"", _prepaidMoney]];
    [orderInfoAttStr appendAttributedString:prepaidMoneyAttStr];
    
    NSAttributedString *balanceMoneyAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n尾款金额：¥%0.1f",_balanceMoney]];
    [orderInfoAttStr appendAttributedString:balanceMoneyAttStr];
    
    NSAttributedString *scoreNumAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n使用积分：%zd",_scoreNum]];
    [orderInfoAttStr appendAttributedString:scoreNumAttStr];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 8;
    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName:[UIColor darkGrayColor],
                          NSParagraphStyleAttributeName:paragraph};
    [orderInfoAttStr addAttributes:att range:NSMakeRange(0, orderInfoAttStr.length)];
    _orderInfoStr = orderInfoAttStr;
    
    return YES;
}

- (NSAttributedString *)countDownValueString{
    
    if (_countDownValue<=0) return nil;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:self.countDownValue];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    
    NSString *timeStr = @"";
    if (components.year>0) {
        timeStr = [NSString stringWithFormat:@"%.2zd年%.2zd月%.2zd日%.2zd时%.2zd分%.2zd秒",components.year,components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.month>0){
        timeStr = [NSString stringWithFormat:@"%.2zd月%.2zd日%.2zd时%.2zd分%.2zd秒",components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.day>0){
        timeStr = [NSString stringWithFormat:@"%.2zd日%.2zd时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        timeStr = [NSString stringWithFormat:@"%.2zd时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        timeStr = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        timeStr = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _countDownValue--;
    
    NSDictionary *countDownStrAtt = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                      NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：",self.countDownStr] attributes:countDownStrAtt];
    
    NSDictionary *timeAtt = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                              NSForegroundColorAttributeName:COLOR_PINK_FLASH};
    NSAttributedString *timerAttString = [[NSAttributedString alloc]initWithString:timeStr attributes:timeAtt];
    [totalStr appendAttributedString:timerAttString];
    
    return totalStr;
}
@end

@implementation FlashServiceOrderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
