//
//  RadishOrderDetailBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailBtn.h"
#import "Colours.h"

@implementation RadishOrderDetailBtn
+ (instancetype)btnWithType:(RadishOrderDetailBtnType)type isHighLight:(BOOL)isHighLight {
    RadishOrderDetailBtn *btn = [RadishOrderDetailBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case RadishOrderDetailBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case RadishOrderDetailBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case RadishOrderDetailBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case RadishOrderDetailBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case RadishOrderDetailBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case RadishOrderDetailBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case RadishOrderDetailBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case RadishOrderDetailBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case RadishOrderDetailBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case RadishOrderDetailBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case RadishOrderDetailBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case RadishOrderDetailBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case RadishOrderDetailBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case RadishOrderDetailBtnTypeRefund:
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
