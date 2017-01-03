//
//  ProductOrderListBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderListItem.h"

typedef enum : NSUInteger {
    ProductOrderListBaseCellActionTypePay = 1,/// 付款
    ProductOrderListBaseCellActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderListBaseCellActionTypeConnectService = 3,/// 联系客服
    ProductOrderListBaseCellActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderListBaseCellActionTypeConsumeCode = 5,/// 取票码
    ProductOrderListBaseCellActionTypeReserve = 6,/// 我要预约
    ProductOrderListBaseCellActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderListBaseCellActionTypeWantTip = 8,/// 活动提醒
    ProductOrderListBaseCellActionTypeReminder = 9,/// 我要催单
    ProductOrderListBaseCellActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderListBaseCellActionTypeEvaluate = 11,/// 评价
    ProductOrderListBaseCellActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderListBaseCellActionTypeComplaint = 13,/// 投诉
    ProductOrderListBaseCellActionTypeRefund = 14,//申请售后
    ProductOrderListBaseCellActionTypeCountDownOver,//倒计时结束
    
    ProductOrderListBaseCellActionTypeStore = 50,//门店详情
    ProductOrderListBaseCellActionTypeSegue = 51,//通用跳转
    ProductOrderListBaseCellActionTypeCall = 52,//打电话
    
} ProductOrderListBaseCellActionType;

@class ProductOrderListBaseCell;
@protocol ProductOrderListBaseCellDelegate <NSObject>
- (void)productOrderListBaseCell:(ProductOrderListBaseCell *)cell actionType:(ProductOrderListBaseCellActionType)type value:(id)value;
@end

@interface ProductOrderListBaseCell : UITableViewCell
@property (nonatomic, strong) ProductOrderListItem *item;
@property (nonatomic, weak) id<ProductOrderListBaseCellDelegate> delegate;
@end
