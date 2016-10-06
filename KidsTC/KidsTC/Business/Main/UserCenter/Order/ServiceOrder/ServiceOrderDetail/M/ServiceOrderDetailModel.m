//
//  ServiceOrderDetailModel.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailModel.h"
#import "NSString+Category.h"

@implementation ServiceOrderDetailInsurance
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    NSAttributedString *sstStr = [self attributeStringTitle:@" 随时退" boolValue:_refund_anytime];
    NSAttributedString *gqtStr = [self attributeStringTitle:@" 过期退" boolValue:_refund_outdate];
    NSAttributedString *bftStr = [self attributeStringTitle:@" 部分退" boolValue:_refund_part];
    
    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc]init];
    if (sstStr.length>0) [tipStr appendAttributedString:sstStr];
    if (gqtStr.length>0) {
        if (tipStr.length>0) {
            NSAttributedString *emptyStr = [[NSAttributedString alloc]initWithString:@"  "];
            [tipStr appendAttributedString:emptyStr];
        }
        [tipStr appendAttributedString:gqtStr];
    };
    if (bftStr.length>0) {
        if (tipStr.length>0) {
            NSAttributedString *emptyStr = [[NSAttributedString alloc]initWithString:@"  "];
            [tipStr appendAttributedString:emptyStr];
        }
        [tipStr appendAttributedString:bftStr];
    }
    if (tipStr.length>0) _tipStr = tipStr;
    
    _canShow = _tipStr.length>0;
    return YES;
}
- (NSAttributedString *)attributeStringTitle:(NSString *)title boolValue:(BOOL)boolValue{
    
    if (boolValue) {
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor colorWithRed:0.347  green:0.820  blue:0.627 alpha:1];
        NSTextAttachment *imageArrachment = [[NSTextAttachment alloc]init];
        imageArrachment.image = [UIImage imageNamed:@"insurance_checked"];
        NSAttributedString *imageAttributeStr = [NSAttributedString attributedStringWithAttachment:imageArrachment];
        imageArrachment.bounds = CGRectMake(0, -2, font.lineHeight-2, font.lineHeight-2);
        
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:color};
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:title attributes:attributes];
        [attributeString insertAttributedString:imageAttributeStr atIndex:0];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributeString.length)];
        return attributeString;
    }
    return nil;
}
@end

@implementation ServiceOrderDetailRefund
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableAttributedString *refundDescAttStr = [[NSMutableAttributedString alloc]init];
    if (_consume_codes.count>0) {
        __block NSMutableString *consumeCodesStr = [[NSMutableString alloc]init];
        NSUInteger count = _consume_codes.count;
        [_consume_codes enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [consumeCodesStr appendFormat:@"%@%@",obj,idx==count-1?@"":@","];
        }];
        if (consumeCodesStr.length>0) {
            NSMutableAttributedString *oderIdAttStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"消费编码：%@",consumeCodesStr]];
            [refundDescAttStr appendAttributedString:oderIdAttStr];
        }
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
                              NSForegroundColorAttributeName:COLOR_PINK,
                              NSParagraphStyleAttributeName:paragraph};
        NSString *noticeStr = [NSString stringWithFormat:@"%@%@",refundDescAttStr.length>0?@"\n":@"",_refund_notice];
        NSAttributedString *noticeAttStr = [[NSAttributedString alloc]initWithString:noticeStr attributes:att];
        [refundDescAttStr appendAttributedString:noticeAttStr];
    }
    
    _refundDescStr = refundDescAttStr;
    
    return YES;
}
@end

@implementation ServiceOrderDetailRemark

@end

@implementation ServiceOrderDetailUserAddress


@end

@implementation ServiceOrderDetailData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"refunds" : [ServiceOrderDetailRefund class],
             @"remarks" : [ServiceOrderDetailRemark class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
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
    
    NSString *phonesString =  dic[@"supplierPhone"];
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
    
    if (self.remarks.count>0) {
        __block NSMutableAttributedString *remaksAttStr = [[NSMutableAttributedString alloc]init];
        [self.remarks enumerateObjectsUsingBlock:^(ServiceOrderDetailRemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
//    NSAttributedString *oderIdAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单编号：%@",_oderId]];
//    [orderInfoAttStr appendAttributedString:oderIdAttStr];
    
    if ([_orderDetailDesc isNotNull]) {
        NSAttributedString *orderStateNameAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单状态：%@",_orderDetailDesc]];
        [orderInfoAttStr appendAttributedString:orderStateNameAttStr];
    }
    
    if ([_time isNotNull]) {
        NSAttributedString *timeAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@下单时间：%@",orderInfoAttStr.length>0?@"\n":@"",_time]];
        [orderInfoAttStr appendAttributedString:timeAttStr];
    }
    
    if ([_phone isNotNull]) {
        NSAttributedString *phoneAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n手机号码：%@",_phone]];
        [orderInfoAttStr appendAttributedString:phoneAttStr];
    }
    
//    if (_count) {
//        NSAttributedString *countAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n下单数量：%zd",_count]];
//        [orderInfoAttStr appendAttributedString:countAttStr];
//    }
    
//    NSAttributedString *totalPriceAttStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n订单总价：¥%0.1f",_totalPrice]];
//    [orderInfoAttStr appendAttributedString:totalPriceAttStr];
    
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
    
    if (_remainingTime<=0) return nil;
    
    UIFont *font = [UIFont boldSystemFontOfSize:17];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_remainingTime];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:date options:0];
    
    NSString *timeStr = @"";
    if (components.year>0) {
        timeStr = [NSString stringWithFormat:@"%.2zd年%.2zd月%.2zd天%.2zd小时%.2zd分%.2zd秒",components.year,components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.month>0){
        timeStr = [NSString stringWithFormat:@"%.2zd月%.2zd天%.2zd小时%.2zd分%.2zd秒",components.month,components.day,components.hour,components.minute,components.second];
    }else if (components.day>0){
        timeStr = [NSString stringWithFormat:@"%.2zd天%.2zd小时%.2zd分%.2zd秒",components.day,components.hour,components.minute,components.second];
    }else if (components.hour>0){
        timeStr = [NSString stringWithFormat:@"%.2zd小时%.2zd分%.2zd秒",components.hour,components.minute,components.second];
    }else if (components.minute>0){
        timeStr = [NSString stringWithFormat:@"%.2zd分%.2zd秒",components.minute,components.second];
    }else if (components.second>=0){
        timeStr = [NSString stringWithFormat:@"%.2zd秒",components.second];
    }
    _remainingTime--;
    
    static NSMutableAttributedString *oneStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImage *image = [[UIImage imageNamed:@"countDonw_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.bounds = CGRectMake(0, -3, font.lineHeight-2, font.lineHeight-2);
        attachment.image = image;
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSDictionary *countDownStrAtt = @{NSFontAttributeName:font,
                                          NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        oneStr = [[NSMutableAttributedString alloc]init];
        [oneStr appendAttributedString:imageStr];
        
        NSMutableAttributedString *leftStr = [[NSMutableAttributedString alloc]initWithString:@" 剩余：" attributes:countDownStrAtt];
        [oneStr appendAttributedString:leftStr];
    });
    
    
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc]init];
    [totalStr appendAttributedString:oneStr];
    
    NSDictionary *timeAtt = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:COLOR_PINK_FLASH};
    NSAttributedString *timerAttString = [[NSAttributedString alloc]initWithString:timeStr attributes:timeAtt];
    [totalStr appendAttributedString:timerAttString];
    
    return totalStr;
}
@end


@implementation ServiceOrderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
