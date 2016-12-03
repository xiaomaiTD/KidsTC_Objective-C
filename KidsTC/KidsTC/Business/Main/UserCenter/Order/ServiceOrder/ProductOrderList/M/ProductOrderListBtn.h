//
//  ProductOrderListBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 /// <summary>
 /// 付款
 /// </summary>
 Pay = 1,
 /// <summary>
 /// 取消订单
 /// </summary>
 CancelOrder = 2,
 /// <summary>
 /// 联系客服
 /// </summary>
 ConnectService = 3,
 /// <summary>
 /// 联系商家
 /// </summary>
 ConnectSupplier = 4,
 /// <summary>
 /// 取票码
 /// </summary>
 ConsumeCode = 5,
 /// <summary>
 /// 我要预约
 /// </summary>
 Reserve = 6,
 /// <summary>
 /// 取消提醒
 /// </summary>
 CancelTip = 7,
 /// <summary>
 /// 活动提醒
 /// </summary>
 WantTip = 8,
 /// <summary>
 /// 我要催单
 /// </summary>
 Reminder = 9,
 /// <summary>
 /// 确认收货
 /// </summary>
 ConfirmDeliver = 10,
 /// <summary>
 /// 评价
 /// </summary>
 Evaluate = 11,
 /// <summary>
 /// 再次购买
 /// </summary>
 BuyAgain = 12,
 /// <summary>
 /// 投诉
 /// </summary>
 Complaint = 13
 */

typedef enum : NSUInteger {
    ProductOrderListBtnTypePay = 1,/// 付款
    ProductOrderListBtnTypeCancelOrder = 2,/// 取消订单
    ProductOrderListBtnTypeConnectService = 3,/// 联系客服
    ProductOrderListBtnTypeConnectSupplier = 4,/// 联系商家
    ProductOrderListBtnTypeConsumeCode = 5,/// 取票码
    ProductOrderListBtnTypeReserve = 6,/// 我要预约
    ProductOrderListBtnTypeCancelTip = 7,/// 取消提醒
    ProductOrderListBtnTypeWantTip = 8,/// 活动提醒
    ProductOrderListBtnTypeReminder = 9,/// 我要催单
    ProductOrderListBtnTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderListBtnTypeEvaluate = 11,/// 评价
    ProductOrderListBtnTypeBuyAgain = 12,/// 再次购买
    ProductOrderListBtnTypeComplaint = 13,/// 投诉
} ProductOrderListBtnType;

@interface ProductOrderListBtn : NSObject
@property (nonatomic, assign) ProductOrderListBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(ProductOrderListBtnType)type isHighLight:(BOOL)isHighLight;
@end
