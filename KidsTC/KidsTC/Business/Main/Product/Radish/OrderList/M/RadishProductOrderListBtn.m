//
//  RadishProductOrderListBtn.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListBtn.h"
#import "Colours.h"

@implementation RadishProductOrderListBtn

+ (instancetype)btnWithType:(RadishProductOrderListBtnType)type isHighLight:(BOOL)isHighLight {
    RadishProductOrderListBtn *btn = [RadishProductOrderListBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case RadishProductOrderListBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case RadishProductOrderListBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case RadishProductOrderListBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case RadishProductOrderListBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case RadishProductOrderListBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case RadishProductOrderListBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case RadishProductOrderListBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case RadishProductOrderListBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case RadishProductOrderListBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case RadishProductOrderListBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case RadishProductOrderListBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case RadishProductOrderListBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case RadishProductOrderListBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case RadishProductOrderListBtnTypeRefund:
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
