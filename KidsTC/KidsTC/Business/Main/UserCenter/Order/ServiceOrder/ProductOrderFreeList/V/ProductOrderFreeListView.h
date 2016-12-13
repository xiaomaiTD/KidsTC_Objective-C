//
//  ProductOrderFreeListView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProductOrderFreeListPageCount 10

typedef enum : NSUInteger {
    
    ProductOrderFreeListViewActionTypePay = 1,/// 付款
    ProductOrderFreeListViewActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeListViewActionTypeConnectService = 3,/// 联系客服
    ProductOrderFreeListViewActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeListViewActionTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeListViewActionTypeReserve = 6,/// 我要预约
    ProductOrderFreeListViewActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeListViewActionTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeListViewActionTypeReminder = 9,/// 我要催单
    ProductOrderFreeListViewActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeListViewActionTypeEvaluate = 11,/// 评价
    ProductOrderFreeListViewActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeListViewActionTypeComplaint = 13,/// 投诉
    ProductOrderFreeListViewActionTypeRefund = 14,//申请售后
    
    ProductOrderFreeListViewActionTypeStore = 50,//门店详情
    
    ProductOrderFreeListViewActionTypeLoadData = 100,//加载数据
    ProductOrderFreeListViewActionTypeSegue = 101,//通用跳转
    
} ProductOrderFreeListViewActionType;

@class ProductOrderFreeListView;
@protocol ProductOrderFreeListViewDelegate <NSObject>
- (void)productOrderFreeListView:(ProductOrderFreeListView *)view actionType:(ProductOrderFreeListViewActionType)type value:(id)value;
@end

@interface ProductOrderFreeListView : UIView
@property (nonatomic, weak) id<ProductOrderFreeListViewDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
- (void)beginRefreshing;
- (void)dealWithUI:(NSUInteger)loadCount;
- (void)reloadData;
@end
