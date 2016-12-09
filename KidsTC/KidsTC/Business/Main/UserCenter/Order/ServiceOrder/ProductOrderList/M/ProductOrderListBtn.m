//
//  ProductOrderListBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListBtn.h"
#import "Colours.h"

@implementation ProductOrderListBtn

+ (instancetype)btnWithType:(ProductOrderListBtnType)type isHighLight:(BOOL)isHighLight {
    ProductOrderListBtn *btn = [ProductOrderListBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case ProductOrderListBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case ProductOrderListBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case ProductOrderListBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case ProductOrderListBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case ProductOrderListBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case ProductOrderListBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case ProductOrderListBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case ProductOrderListBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case ProductOrderListBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case ProductOrderListBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case ProductOrderListBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case ProductOrderListBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case ProductOrderListBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case ProductOrderListBtnTypeRefund:
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
