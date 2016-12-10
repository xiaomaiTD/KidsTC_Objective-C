//
//  ProductOrderFreeDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailData.h"

extern CGFloat const kProductOrderFreeDetailToolBarH;

typedef enum : NSUInteger {
    ProductOrderFreeDetailToolBarActionTypePay = 1,/// 付款
    ProductOrderFreeDetailToolBarActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeDetailToolBarActionTypeConnectService = 3,/// 联系客服
    ProductOrderFreeDetailToolBarActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeDetailToolBarActionTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeDetailToolBarActionTypeReserve = 6,/// 我要预约
    ProductOrderFreeDetailToolBarActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeDetailToolBarActionTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeDetailToolBarActionTypeReminder = 9,/// 我要催单
    ProductOrderFreeDetailToolBarActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeDetailToolBarActionTypeEvaluate = 11,/// 评价
    ProductOrderFreeDetailToolBarActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeDetailToolBarActionTypeComplaint = 13,/// 投诉
    ProductOrderFreeDetailToolBarActionTypeRefund = 14,//申请售后
} ProductOrderFreeDetailToolBarActionType;

@class ProductOrderFreeDetailToolBar;
@protocol ProductOrderFreeDetailToolBarDelegate <NSObject>
- (void)productOrderFreeDetailToolBar:(ProductOrderFreeDetailToolBar *)toolBar actionType:(ProductOrderFreeDetailToolBarActionType)type value:(id)value;
@end

@interface ProductOrderFreeDetailToolBar : UIView
@property (nonatomic, strong) ProductOrderFreeDetailData *data;
@property (nonatomic, weak) id<ProductOrderFreeDetailToolBarDelegate> delegate;
@end
