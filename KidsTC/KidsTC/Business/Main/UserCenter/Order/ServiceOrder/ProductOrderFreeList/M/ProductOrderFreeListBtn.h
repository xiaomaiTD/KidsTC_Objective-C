//
//  ProductOrderFreeListBtn.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderFreeListBtnTypePay = 1,/// 付款
    ProductOrderFreeListBtnTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeListBtnTypeConnectService = 3,/// 联系客服
    ProductOrderFreeListBtnTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeListBtnTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeListBtnTypeReserve = 6,/// 我要预约
    ProductOrderFreeListBtnTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeListBtnTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeListBtnTypeReminder = 9,/// 我要催单
    ProductOrderFreeListBtnTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeListBtnTypeEvaluate = 11,/// 评价
    ProductOrderFreeListBtnTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeListBtnTypeComplaint = 13,/// 投诉
    ProductOrderFreeListBtnTypeRefund = 14,//申请售后
} ProductOrderFreeListBtnType;

@interface ProductOrderFreeListBtn : NSObject
@property (nonatomic, assign) ProductOrderFreeListBtnType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) BOOL isHighLight;//是否为红色
+ (instancetype)btnWithType:(ProductOrderFreeListBtnType)type isHighLight:(BOOL)isHighLight;
@end
