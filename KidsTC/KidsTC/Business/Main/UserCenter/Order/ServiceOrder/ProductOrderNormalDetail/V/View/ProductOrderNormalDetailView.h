//
//  ProductOrderNormalDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderNormalDetailData.h"

typedef enum : NSUInteger {
    ProductOrderNormalDetailViewActionTypePay = 1,/// 付款
    ProductOrderNormalDetailViewActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderNormalDetailViewActionTypeConnectService = 3,/// 联系客服
    ProductOrderNormalDetailViewActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderNormalDetailViewActionTypeConsumeCode = 5,/// 取票码
    ProductOrderNormalDetailViewActionTypeReserve = 6,/// 我要预约
    ProductOrderNormalDetailViewActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderNormalDetailViewActionTypeWantTip = 8,/// 活动提醒
    ProductOrderNormalDetailViewActionTypeReminder = 9,/// 我要催单
    ProductOrderNormalDetailViewActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderNormalDetailViewActionTypeEvaluate = 11,/// 评价
    ProductOrderNormalDetailViewActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderNormalDetailViewActionTypeComplaint = 13,/// 投诉
    ProductOrderNormalDetailViewActionTypeRefund = 14,//申请售后
    ProductOrderNormalDetailViewActionTypeCountDownOver,//倒计时结束
    
    ProductOrderNormalDetailViewActionTypeSegue = 50,//通用跳转
    ProductOrderNormalDetailViewActionTypeDeliberCall,//订单电话
    ProductOrderNormalDetailViewActionTypeBooking,//我要预约
    ProductOrderNormalDetailViewActionTypeBookingMustEdit,//我要预约，编辑
    ProductOrderNormalDetailViewActionTypeContact,//联系商家
    ProductOrderNormalDetailViewActionTypeShowRule,//查看公告
} ProductOrderNormalDetailViewActionType;

@class ProductOrderNormalDetailView;
@protocol ProductOrderNormalDetailViewDelegate <NSObject>
- (void)productOrderNormalDetailView:(ProductOrderNormalDetailView *)view actionType:(ProductOrderNormalDetailViewActionType)type value:(id)value;
@end

@interface ProductOrderNormalDetailView : UIView
@property (nonatomic, weak) id<ProductOrderNormalDetailViewDelegate> delegate;
@property (nonatomic, weak) ProductOrderNormalDetailData *data;
- (void)reloadData;
@end
