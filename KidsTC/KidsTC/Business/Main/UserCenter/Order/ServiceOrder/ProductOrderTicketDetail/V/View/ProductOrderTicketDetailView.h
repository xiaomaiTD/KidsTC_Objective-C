//
//  ProductOrderTicketDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderTicketDetailData.h"

typedef enum : NSUInteger {
    ProductOrderTicketDetailViewActionTypePay = 1,/// 付款
    ProductOrderTicketDetailViewActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderTicketDetailViewActionTypeConnectService = 3,/// 联系客服
    ProductOrderTicketDetailViewActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderTicketDetailViewActionTypeConsumeCode = 5,/// 取票码
    ProductOrderTicketDetailViewActionTypeReserve = 6,/// 我要预约
    ProductOrderTicketDetailViewActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderTicketDetailViewActionTypeWantTip = 8,/// 活动提醒
    ProductOrderTicketDetailViewActionTypeReminder = 9,/// 我要催单
    ProductOrderTicketDetailViewActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderTicketDetailViewActionTypeEvaluate = 11,/// 评价
    ProductOrderTicketDetailViewActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderTicketDetailViewActionTypeComplaint = 13,/// 投诉
    ProductOrderTicketDetailViewActionTypeRefund = 14,//申请售后
    ProductOrderTicketDetailViewActionTypeCountDownOver,//倒计时结束
    
    ProductOrderTicketDetailViewActionTypeSegue = 50,//通用跳转
    ProductOrderTicketDetailViewActionTypeDeliberCall,//订单电话
    ProductOrderTicketDetailViewActionTypeContact,//联系商家
    
} ProductOrderTicketDetailViewActionType;

@class ProductOrderTicketDetailView;
@protocol ProductOrderTicketDetailViewDelegate <NSObject>
- (void)productOrderTicketDetailView:(ProductOrderTicketDetailView *)view actionType:(ProductOrderTicketDetailViewActionType)type value:(id)value;
@end

@interface ProductOrderTicketDetailView : UIView
@property (nonatomic, weak) id<ProductOrderTicketDetailViewDelegate> delegate;
@property (nonatomic, weak) ProductOrderTicketDetailData *data;
- (void)reloadData;
@end
