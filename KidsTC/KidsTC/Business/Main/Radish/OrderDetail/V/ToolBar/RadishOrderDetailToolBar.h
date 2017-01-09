//
//  RadishOrderDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishOrderDetailData.h"

extern CGFloat const kRadishOrderDetailToolBarH;

typedef enum : NSUInteger {
    RadishOrderDetailToolBarActionTypePay = 1,/// 付款
    RadishOrderDetailToolBarActionTypeCancelOrder = 2,/// 取消订单
    RadishOrderDetailToolBarActionTypeConnectService = 3,/// 联系客服
    RadishOrderDetailToolBarActionTypeConnectSupplier = 4,/// 联系商家
    RadishOrderDetailToolBarActionTypeConsumeCode = 5,/// 取票码
    RadishOrderDetailToolBarActionTypeReserve = 6,/// 我要预约
    RadishOrderDetailToolBarActionTypeCancelTip = 7,/// 取消提醒
    RadishOrderDetailToolBarActionTypeWantTip = 8,/// 活动提醒
    RadishOrderDetailToolBarActionTypeReminder = 9,/// 我要催单
    RadishOrderDetailToolBarActionTypeConfirmDeliver = 10,/// 确认收货
    RadishOrderDetailToolBarActionTypeEvaluate = 11,/// 评价
    RadishOrderDetailToolBarActionTypeBuyAgain = 12,/// 再次购买
    RadishOrderDetailToolBarActionTypeComplaint = 13,/// 投诉
    RadishOrderDetailToolBarActionTypeRefund = 14,//申请售后
    RadishOrderDetailToolBarActionTypeCountDownOver,//倒计时结束
} RadishOrderDetailToolBarActionType;

@class RadishOrderDetailToolBar;
@protocol RadishOrderDetailToolBarDelegate <NSObject>
- (void)radishOrderDetailToolBar:(RadishOrderDetailToolBar *)toolBar actionType:(RadishOrderDetailToolBarActionType)type value:(id)value;
@end

@interface RadishOrderDetailToolBar : UIView
@property (nonatomic, strong) RadishOrderDetailData *data;
@property (nonatomic, weak) id<RadishOrderDetailToolBarDelegate> delegate;
@end
