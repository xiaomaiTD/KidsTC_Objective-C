//
//  ProductOrderTicketDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderTicketDetailData.h"

extern CGFloat const kProductOrderTicketDetailToolBarH;

typedef enum : NSUInteger {
    ProductOrderTicketDetailToolBarActionTypePay = 1,/// 付款
    ProductOrderTicketDetailToolBarActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderTicketDetailToolBarActionTypeConnectService = 3,/// 联系客服
    ProductOrderTicketDetailToolBarActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderTicketDetailToolBarActionTypeConsumeCode = 5,/// 取票码
    ProductOrderTicketDetailToolBarActionTypeReserve = 6,/// 我要预约
    ProductOrderTicketDetailToolBarActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderTicketDetailToolBarActionTypeWantTip = 8,/// 活动提醒
    ProductOrderTicketDetailToolBarActionTypeReminder = 9,/// 我要催单
    ProductOrderTicketDetailToolBarActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderTicketDetailToolBarActionTypeEvaluate = 11,/// 评价
    ProductOrderTicketDetailToolBarActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderTicketDetailToolBarActionTypeComplaint = 13,/// 投诉
    ProductOrderTicketDetailToolBarActionTypeRefund = 14,//申请售后
    ProductOrderTicketDetailToolBarActionTypeCountDownOver,//倒计时结束
} ProductOrderTicketDetailToolBarActionType;

@class ProductOrderTicketDetailToolBar;
@protocol ProductOrderTicketDetailToolBarDelegate <NSObject>
- (void)productOrderTicketDetailToolBar:(ProductOrderTicketDetailToolBar *)toolBar actionType:(ProductOrderTicketDetailToolBarActionType)type value:(id)value;
@end

@interface ProductOrderTicketDetailToolBar : UIView
@property (nonatomic, strong) ProductOrderTicketDetailData *data;
@property (nonatomic, weak) id<ProductOrderTicketDetailToolBarDelegate> delegate;
@end
