//
//  ProductOrderTicketDetailBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailBtn.h"
#import "Colours.h"

@implementation ProductOrderTicketDetailBtn
+ (instancetype)btnWithType:(ProductOrderTicketDetailBtnType)type isHighLight:(BOOL)isHighLight {
    ProductOrderTicketDetailBtn *btn = [ProductOrderTicketDetailBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case ProductOrderTicketDetailBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case ProductOrderTicketDetailBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case ProductOrderTicketDetailBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case ProductOrderTicketDetailBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case ProductOrderTicketDetailBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case ProductOrderTicketDetailBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case ProductOrderTicketDetailBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case ProductOrderTicketDetailBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case ProductOrderTicketDetailBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case ProductOrderTicketDetailBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case ProductOrderTicketDetailBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case ProductOrderTicketDetailBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case ProductOrderTicketDetailBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case ProductOrderTicketDetailBtnTypeRefund:
        {
            btn.title = @"申请售后";
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
    return btn;
}
@end
