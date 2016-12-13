//
//  ProductOrderTicketDetailBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderTicketDetailBtnTypePay = 1,/// 付款
    ProductOrderTicketDetailBtnTypeCancelOrder = 2,/// 取消订单
    ProductOrderTicketDetailBtnTypeConnectService = 3,/// 联系客服
    ProductOrderTicketDetailBtnTypeConnectSupplier = 4,/// 联系商家
    ProductOrderTicketDetailBtnTypeConsumeCode = 5,/// 取票码
    ProductOrderTicketDetailBtnTypeReserve = 6,/// 我要预约
    ProductOrderTicketDetailBtnTypeCancelTip = 7,/// 取消提醒
    ProductOrderTicketDetailBtnTypeWantTip = 8,/// 活动提醒
    ProductOrderTicketDetailBtnTypeReminder = 9,/// 我要催单
    ProductOrderTicketDetailBtnTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderTicketDetailBtnTypeEvaluate = 11,/// 评价
    ProductOrderTicketDetailBtnTypeBuyAgain = 12,/// 再次购买
    ProductOrderTicketDetailBtnTypeComplaint = 13,/// 投诉
    ProductOrderTicketDetailBtnTypeRefund = 14,//申请售后
} ProductOrderTicketDetailBtnType;

@interface ProductOrderTicketDetailBtn : NSObject
@property (nonatomic, assign) ProductOrderTicketDetailBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(ProductOrderTicketDetailBtnType)type isHighLight:(BOOL)isHighLight;
@end
