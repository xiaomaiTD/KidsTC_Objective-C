//
//  ProductOrderNormalDetailBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderNormalDetailBtnTypePay = 1,/// 付款
    ProductOrderNormalDetailBtnTypeCancelOrder = 2,/// 取消订单
    ProductOrderNormalDetailBtnTypeConnectService = 3,/// 联系客服
    ProductOrderNormalDetailBtnTypeConnectSupplier = 4,/// 联系商家
    ProductOrderNormalDetailBtnTypeConsumeCode = 5,/// 取票码
    ProductOrderNormalDetailBtnTypeReserve = 6,/// 我要预约
    ProductOrderNormalDetailBtnTypeCancelTip = 7,/// 取消提醒
    ProductOrderNormalDetailBtnTypeWantTip = 8,/// 活动提醒
    ProductOrderNormalDetailBtnTypeReminder = 9,/// 我要催单
    ProductOrderNormalDetailBtnTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderNormalDetailBtnTypeEvaluate = 11,/// 评价
    ProductOrderNormalDetailBtnTypeBuyAgain = 12,/// 再次购买
    ProductOrderNormalDetailBtnTypeComplaint = 13,/// 投诉
    ProductOrderNormalDetailBtnTypeRefund = 14,//申请售后
} ProductOrderNormalDetailBtnType;

@interface ProductOrderNormalDetailBtn : NSObject
@property (nonatomic, assign) ProductOrderNormalDetailBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(ProductOrderNormalDetailBtnType)type isHighLight:(BOOL)isHighLight;
@end
