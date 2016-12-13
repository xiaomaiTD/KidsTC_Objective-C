//
//  ProductOrderNormalDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderNormalDetailData.h"

extern CGFloat const kProductOrderNormalDetailToolBarH;

typedef enum : NSUInteger {
    ProductOrderNormalDetailToolBarActionTypePay = 1,/// 付款
    ProductOrderNormalDetailToolBarActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderNormalDetailToolBarActionTypeConnectService = 3,/// 联系客服
    ProductOrderNormalDetailToolBarActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderNormalDetailToolBarActionTypeConsumeCode = 5,/// 取票码
    ProductOrderNormalDetailToolBarActionTypeReserve = 6,/// 我要预约
    ProductOrderNormalDetailToolBarActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderNormalDetailToolBarActionTypeWantTip = 8,/// 活动提醒
    ProductOrderNormalDetailToolBarActionTypeReminder = 9,/// 我要催单
    ProductOrderNormalDetailToolBarActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderNormalDetailToolBarActionTypeEvaluate = 11,/// 评价
    ProductOrderNormalDetailToolBarActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderNormalDetailToolBarActionTypeComplaint = 13,/// 投诉
    ProductOrderNormalDetailToolBarActionTypeRefund = 14,//申请售后
    ProductOrderNormalDetailToolBarActionTypeCountDownOver,//倒计时结束
} ProductOrderNormalDetailToolBarActionType;

@class ProductOrderNormalDetailToolBar;
@protocol ProductOrderNormalDetailToolBarDelegate <NSObject>
- (void)productOrderNormalDetailToolBar:(ProductOrderNormalDetailToolBar *)toolBar actionType:(ProductOrderNormalDetailToolBarActionType)type value:(id)value;
@end

@interface ProductOrderNormalDetailToolBar : UIView
@property (nonatomic, strong) ProductOrderNormalDetailData *data;
@property (nonatomic, weak) id<ProductOrderNormalDetailToolBarDelegate> delegate;
@end
