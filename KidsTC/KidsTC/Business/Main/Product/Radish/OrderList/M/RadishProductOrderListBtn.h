//
//  RadishProductOrderListBtn.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RadishProductOrderListBtnTypePay = 1,/// 付款
    RadishProductOrderListBtnTypeCancelOrder = 2,/// 取消订单
    RadishProductOrderListBtnTypeConnectService = 3,/// 联系客服
    RadishProductOrderListBtnTypeConnectSupplier = 4,/// 联系商家
    RadishProductOrderListBtnTypeConsumeCode = 5,/// 取票码
    RadishProductOrderListBtnTypeReserve = 6,/// 我要预约
    RadishProductOrderListBtnTypeCancelTip = 7,/// 取消提醒
    RadishProductOrderListBtnTypeWantTip = 8,/// 活动提醒
    RadishProductOrderListBtnTypeReminder = 9,/// 我要催单
    RadishProductOrderListBtnTypeConfirmDeliver = 10,/// 确认收货
    RadishProductOrderListBtnTypeEvaluate = 11,/// 评价
    RadishProductOrderListBtnTypeBuyAgain = 12,/// 再次购买
    RadishProductOrderListBtnTypeComplaint = 13,/// 投诉
    RadishProductOrderListBtnTypeRefund = 14,//申请售后
} RadishProductOrderListBtnType;

@interface RadishProductOrderListBtn : NSObject
@property (nonatomic, assign) RadishProductOrderListBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(RadishProductOrderListBtnType)type isHighLight:(BOOL)isHighLight;
@end
