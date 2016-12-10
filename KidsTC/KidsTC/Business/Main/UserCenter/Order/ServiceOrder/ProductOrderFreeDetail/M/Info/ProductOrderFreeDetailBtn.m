//
//  ProductOrderFreeDetailBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailBtn.h"
#import "Colours.h"

@implementation ProductOrderFreeDetailBtn
+ (instancetype)btnWithType:(ProductOrderFreeDetailBtnType)type isHighLight:(BOOL)isHighLight {
    ProductOrderFreeDetailBtn *btn = [ProductOrderFreeDetailBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case ProductOrderFreeDetailBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case ProductOrderFreeDetailBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case ProductOrderFreeDetailBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case ProductOrderFreeDetailBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case ProductOrderFreeDetailBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case ProductOrderFreeDetailBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case ProductOrderFreeDetailBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case ProductOrderFreeDetailBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case ProductOrderFreeDetailBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case ProductOrderFreeDetailBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case ProductOrderFreeDetailBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case ProductOrderFreeDetailBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case ProductOrderFreeDetailBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case ProductOrderFreeDetailBtnTypeRefund:
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
