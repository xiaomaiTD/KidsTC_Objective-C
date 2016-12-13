//
//  ProductOrderTicketDetailRefund.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailRefund.h"
#import "NSString+Category.h"
#import "Colours.h"

@implementation ProductOrderTicketDetailRefund
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"consume_codes":[NSString class]};
}
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
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSForegroundColorAttributeName:[UIColor colorFromHexString:@"222222"],
                              NSParagraphStyleAttributeName:paragraph};
        [refundDescAttStr addAttributes:att range:NSMakeRange(0, refundDescAttStr.length)];
    }
    
    if (_refund_notice.length>0) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.lineSpacing = 6;
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
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
