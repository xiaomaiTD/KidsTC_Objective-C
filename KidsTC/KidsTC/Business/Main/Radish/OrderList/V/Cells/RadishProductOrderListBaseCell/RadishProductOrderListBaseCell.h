//
//  RadishProductOrderListBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductOrderListItem.h"

typedef enum : NSUInteger {
    RadishProductOrderListBaseCellActionTypePay = 1,/// 付款
    RadishProductOrderListBaseCellActionTypeCancelOrder = 2,/// 取消订单
    RadishProductOrderListBaseCellActionTypeConnectService = 3,/// 联系客服
    RadishProductOrderListBaseCellActionTypeConnectSupplier = 4,/// 联系商家
    RadishProductOrderListBaseCellActionTypeConsumeCode = 5,/// 取票码
    RadishProductOrderListBaseCellActionTypeReserve = 6,/// 我要预约
    RadishProductOrderListBaseCellActionTypeCancelTip = 7,/// 取消提醒
    RadishProductOrderListBaseCellActionTypeWantTip = 8,/// 活动提醒
    RadishProductOrderListBaseCellActionTypeReminder = 9,/// 我要催单
    RadishProductOrderListBaseCellActionTypeConfirmDeliver = 10,/// 确认收货
    RadishProductOrderListBaseCellActionTypeEvaluate = 11,/// 评价
    RadishProductOrderListBaseCellActionTypeBuyAgain = 12,/// 再次购买
    RadishProductOrderListBaseCellActionTypeComplaint = 13,/// 投诉
    RadishProductOrderListBaseCellActionTypeRefund = 14,//申请售后
    RadishProductOrderListBaseCellActionTypeCountDownOver,//倒计时结束
    
    RadishProductOrderListBaseCellActionTypeStore = 50,//门店详情
    RadishProductOrderListBaseCellActionTypeSegue = 51,//通用跳转
    RadishProductOrderListBaseCellActionTypeCall = 52,//打电话
    
} RadishProductOrderListBaseCellActionType;

@class RadishProductOrderListBaseCell;
@protocol RadishProductOrderListBaseCellDelegate <NSObject>
- (void)radishProductOrderListBaseCell:(RadishProductOrderListBaseCell *)cell actionType:(RadishProductOrderListBaseCellActionType)type value:(id)value;
@end

@interface RadishProductOrderListBaseCell : UITableViewCell
@property (nonatomic, strong) RadishProductOrderListItem *item;
@property (nonatomic, weak) id<RadishProductOrderListBaseCellDelegate> delegate;
@end
