//
//  ProductOrderFreeListBtn.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListBtn.h"
#import "Colours.h"

@implementation ProductOrderFreeListBtn
+ (instancetype)btnWithType:(ProductOrderFreeListBtnType)type isHighLight:(BOOL)isHighLight {
    ProductOrderFreeListBtn *btn = [ProductOrderFreeListBtn new];
    btn.type = type;
    btn.isHighLight = isHighLight;
    btn.titleColor = isHighLight?[UIColor colorFromHexString:@"F36863"]:[UIColor colorFromHexString:@"444444"];
    btn.borderColor = isHighLight?[UIColor colorFromHexString:@"fd898a"]:[UIColor colorFromHexString:@"999999"];
    switch (type) {
        case ProductOrderFreeListBtnTypePay:
        {
            btn.title = @"付款";
        }
            break;
        case ProductOrderFreeListBtnTypeCancelOrder:
        {
            btn.title = @"取消订单";
        }
            break;
        case ProductOrderFreeListBtnTypeConnectService:
        {
            btn.title = @"联系客服";
        }
            break;
        case ProductOrderFreeListBtnTypeConnectSupplier:
        {
            btn.title = @"联系商家";
        }
            break;
        case ProductOrderFreeListBtnTypeConsumeCode:
        {
            btn.title = @"取票码";
        }
            break;
        case ProductOrderFreeListBtnTypeReserve:
        {
            btn.title = @"我要预约";
        }
            break;
        case ProductOrderFreeListBtnTypeCancelTip:
        {
            btn.title = @"取消提醒";
        }
            break;
        case ProductOrderFreeListBtnTypeWantTip:
        {
            btn.title = @"活动提醒";
        }
            break;
        case ProductOrderFreeListBtnTypeReminder:
        {
            btn.title = @"我要催单";
        }
            break;
        case ProductOrderFreeListBtnTypeConfirmDeliver:
        {
            btn.title = @"确认收货";
        }
            break;
        case ProductOrderFreeListBtnTypeEvaluate:
        {
            btn.title = @"评价";
        }
            break;
        case ProductOrderFreeListBtnTypeBuyAgain:
        {
            btn.title = @"再次购买";
        }
            break;
        case ProductOrderFreeListBtnTypeComplaint:
        {
            btn.title = @"投诉";
        }
            break;
        case ProductOrderFreeListBtnTypeRefund:
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
