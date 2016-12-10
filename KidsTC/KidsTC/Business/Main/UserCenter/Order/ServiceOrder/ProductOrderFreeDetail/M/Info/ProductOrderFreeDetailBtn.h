//
//  ProductOrderFreeDetailBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderFreeDetailBtnTypePay = 1,/// 付款
    ProductOrderFreeDetailBtnTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeDetailBtnTypeConnectService = 3,/// 联系客服
    ProductOrderFreeDetailBtnTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeDetailBtnTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeDetailBtnTypeReserve = 6,/// 我要预约
    ProductOrderFreeDetailBtnTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeDetailBtnTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeDetailBtnTypeReminder = 9,/// 我要催单
    ProductOrderFreeDetailBtnTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeDetailBtnTypeEvaluate = 11,/// 评价
    ProductOrderFreeDetailBtnTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeDetailBtnTypeComplaint = 13,/// 投诉
    ProductOrderFreeDetailBtnTypeRefund = 14,//申请售后
} ProductOrderFreeDetailBtnType;

@interface ProductOrderFreeDetailBtn : NSObject
@property (nonatomic, assign) ProductOrderFreeDetailBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(ProductOrderFreeDetailBtnType)type isHighLight:(BOOL)isHighLight;
@end
