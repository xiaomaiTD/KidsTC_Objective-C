//
//  ProductOrderFreeListBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeListItem.h"

typedef enum : NSUInteger {
    ProductOrderFreeListBaseCellActionTypePay = 1,/// 付款
    ProductOrderFreeListBaseCellActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeListBaseCellActionTypeConnectService = 3,/// 联系客服
    ProductOrderFreeListBaseCellActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeListBaseCellActionTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeListBaseCellActionTypeReserve = 6,/// 我要预约
    ProductOrderFreeListBaseCellActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeListBaseCellActionTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeListBaseCellActionTypeReminder = 9,/// 我要催单
    ProductOrderFreeListBaseCellActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeListBaseCellActionTypeEvaluate = 11,/// 评价
    ProductOrderFreeListBaseCellActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeListBaseCellActionTypeComplaint = 13,/// 投诉
    ProductOrderFreeListBaseCellActionTypeRefund = 14,//申请售后
    ProductOrderFreeListBaseCellActionTypeCountDownOver,//倒计时结束
    
    ProductOrderFreeListBaseCellActionTypeStore = 50,//门店详情
    
} ProductOrderFreeListBaseCellActionType;

@class ProductOrderFreeListBaseCell;
@protocol ProductOrderFreeListBaseCellDelegate <NSObject>
- (void)productOrderFreeListBaseCell:(ProductOrderFreeListBaseCell *)cell actionType:(ProductOrderFreeListBaseCellActionType)type value:(id)value;
@end

@interface ProductOrderFreeListBaseCell : UITableViewCell
@property (nonatomic, strong) ProductOrderFreeListItem *item;
@property (nonatomic, weak) id<ProductOrderFreeListBaseCellDelegate> delegate;
@end
