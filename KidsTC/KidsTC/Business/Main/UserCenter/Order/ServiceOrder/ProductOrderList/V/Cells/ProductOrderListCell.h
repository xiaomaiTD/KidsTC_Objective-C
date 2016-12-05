//
//  ProductOrderListCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderListItem.h"



typedef enum : NSUInteger {
    ProductOrderListCellActionTypePay = 1,/// 付款
    ProductOrderListCellActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderListCellActionTypeConnectService = 3,/// 联系客服
    ProductOrderListCellActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderListCellActionTypeConsumeCode = 5,/// 取票码
    ProductOrderListCellActionTypeReserve = 6,/// 我要预约
    ProductOrderListCellActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderListCellActionTypeWantTip = 8,/// 活动提醒
    ProductOrderListCellActionTypeReminder = 9,/// 我要催单
    ProductOrderListCellActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderListCellActionTypeEvaluate = 11,/// 评价
    ProductOrderListCellActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderListCellActionTypeComplaint = 13,/// 投诉
    
    ProductOrderListCellActionTypeStore = 14,//门店详情
    
} ProductOrderListCellActionType;

@class ProductOrderListCell;
@protocol ProductOrderListCellDelegate <NSObject>
- (void)productOrderListCell:(ProductOrderListCell *)cell actionType:(ProductOrderListCellActionType)type value:(id)value;
@end

@interface ProductOrderListCell : UITableViewCell
@property (nonatomic, strong) ProductOrderListItem *item;
@property (nonatomic, weak) id<ProductOrderListCellDelegate> delegate;
@end
