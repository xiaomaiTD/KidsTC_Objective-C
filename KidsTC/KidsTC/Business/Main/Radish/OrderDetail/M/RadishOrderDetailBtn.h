//
//  RadishOrderDetailBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RadishOrderDetailBtnTypePay = 1,/// 付款
    RadishOrderDetailBtnTypeCancelOrder = 2,/// 取消订单
    RadishOrderDetailBtnTypeConnectService = 3,/// 联系客服
    RadishOrderDetailBtnTypeConnectSupplier = 4,/// 联系商家
    RadishOrderDetailBtnTypeConsumeCode = 5,/// 取票码
    RadishOrderDetailBtnTypeReserve = 6,/// 我要预约
    RadishOrderDetailBtnTypeCancelTip = 7,/// 取消提醒
    RadishOrderDetailBtnTypeWantTip = 8,/// 活动提醒
    RadishOrderDetailBtnTypeReminder = 9,/// 我要催单
    RadishOrderDetailBtnTypeConfirmDeliver = 10,/// 确认收货
    RadishOrderDetailBtnTypeEvaluate = 11,/// 评价
    RadishOrderDetailBtnTypeBuyAgain = 12,/// 再次购买
    RadishOrderDetailBtnTypeComplaint = 13,/// 投诉
    RadishOrderDetailBtnTypeRefund = 14,//申请售后
} RadishOrderDetailBtnType;

@interface RadishOrderDetailBtn : NSObject
@property (nonatomic, assign) RadishOrderDetailBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(RadishOrderDetailBtnType)type isHighLight:(BOOL)isHighLight;
@end
