//
//  ProductOrderFreeListCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeListItem.h"

typedef enum : NSUInteger {
    ProductOrderFreeListCellActionTypePay = 1,/// 付款
    ProductOrderFreeListCellActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeListCellActionTypeConnectService = 3,/// 联系客服
    ProductOrderFreeListCellActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeListCellActionTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeListCellActionTypeReserve = 6,/// 我要预约
    ProductOrderFreeListCellActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeListCellActionTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeListCellActionTypeReminder = 9,/// 我要催单
    ProductOrderFreeListCellActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeListCellActionTypeEvaluate = 11,/// 评价
    ProductOrderFreeListCellActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeListCellActionTypeComplaint = 13,/// 投诉
    
    ProductOrderFreeListCellActionTypeStore = 14,//门店详情
    
} ProductOrderFreeListCellActionType;

@class ProductOrderFreeListCell;
@protocol ProductOrderFreeListCellDelegate <NSObject>
- (void)productOrderFreeListCell:(ProductOrderFreeListCell *)cell actionType:(ProductOrderFreeListCellActionType)type value:(id)value;
@end

@interface ProductOrderFreeListCell : UITableViewCell
@property (nonatomic, strong) ProductOrderFreeListItem *item;
@property (nonatomic, weak) id<ProductOrderFreeListCellDelegate> delegate;
@end
