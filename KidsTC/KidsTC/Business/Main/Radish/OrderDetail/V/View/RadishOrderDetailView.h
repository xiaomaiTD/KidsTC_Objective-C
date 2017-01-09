//
//  RadishOrderDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishOrderDetailData.h"

typedef enum : NSUInteger {
    RadishOrderDetailViewActionTypePay = 1,/// 付款
    RadishOrderDetailViewActionTypeCancelOrder = 2,/// 取消订单
    RadishOrderDetailViewActionTypeConnectService = 3,/// 联系客服
    RadishOrderDetailViewActionTypeConnectSupplier = 4,/// 联系商家
    RadishOrderDetailViewActionTypeConsumeCode = 5,/// 取票码
    RadishOrderDetailViewActionTypeReserve = 6,/// 我要预约
    RadishOrderDetailViewActionTypeCancelTip = 7,/// 取消提醒
    RadishOrderDetailViewActionTypeWantTip = 8,/// 活动提醒
    RadishOrderDetailViewActionTypeReminder = 9,/// 我要催单
    RadishOrderDetailViewActionTypeConfirmDeliver = 10,/// 确认收货
    RadishOrderDetailViewActionTypeEvaluate = 11,/// 评价
    RadishOrderDetailViewActionTypeBuyAgain = 12,/// 再次购买
    RadishOrderDetailViewActionTypeComplaint = 13,/// 投诉
    RadishOrderDetailViewActionTypeRefund = 14,//申请售后
    RadishOrderDetailViewActionTypeCountDownOver,//倒计时结束
    
    RadishOrderDetailViewActionTypeSegue = 50,//通用跳转
    RadishOrderDetailViewActionTypeDeliberCall,//订单电话
    RadishOrderDetailViewActionTypeBooking,//我要预约
    RadishOrderDetailViewActionTypeBookingMustEdit,//我要预约，编辑
    RadishOrderDetailViewActionTypeContact,//联系商家
    RadishOrderDetailViewActionTypeShowRule,//查看公告
} RadishOrderDetailViewActionType;

@class RadishOrderDetailView;
@protocol RadishOrderDetailViewDelegate <NSObject>
- (void)radishOrderDetailView:(RadishOrderDetailView *)view actionType:(RadishOrderDetailViewActionType)type value:(id)value;
@end

@interface RadishOrderDetailView : UIView
@property (nonatomic, weak) id<RadishOrderDetailViewDelegate> delegate;
@property (nonatomic, weak) RadishOrderDetailData *data;
- (void)reloadData;
@end
