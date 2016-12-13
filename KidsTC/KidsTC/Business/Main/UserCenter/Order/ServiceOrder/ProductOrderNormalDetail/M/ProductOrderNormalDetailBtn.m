//
//  ProductOrderNormalDetailBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailBtn.h"
#import "Colours.h"

@implementation ProductOrderNormalDetailBtn
+ (instancetype)btnWithType:(ProductOrderNormalDetailBtnType)type isHighLight:(BOOL)isHighLight {
    ProductOrderNormalDetailBtn *btn = [ProductOrderNormalDetailBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case ProductOrderNormalDetailBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case ProductOrderNormalDetailBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case ProductOrderNormalDetailBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case ProductOrderNormalDetailBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case ProductOrderNormalDetailBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case ProductOrderNormalDetailBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case ProductOrderNormalDetailBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case ProductOrderNormalDetailBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case ProductOrderNormalDetailBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case ProductOrderNormalDetailBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case ProductOrderNormalDetailBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case ProductOrderNormalDetailBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case ProductOrderNormalDetailBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case ProductOrderNormalDetailBtnTypeRefund:
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
