//
//  ProductOrderListView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProductOrderListPageCount 10

typedef enum : NSUInteger {
    
    ProductOrderListViewActionTypePay = 1,/// 付款
    ProductOrderListViewActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderListViewActionTypeConnectService = 3,/// 联系客服
    ProductOrderListViewActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderListViewActionTypeConsumeCode = 5,/// 取票码
    ProductOrderListViewActionTypeReserve = 6,/// 我要预约
    ProductOrderListViewActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderListViewActionTypeWantTip = 8,/// 活动提醒
    ProductOrderListViewActionTypeReminder = 9,/// 我要催单
    ProductOrderListViewActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderListViewActionTypeEvaluate = 11,/// 评价
    ProductOrderListViewActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderListViewActionTypeComplaint = 13,/// 投诉
    
    ProductOrderListViewActionTypeStore = 14,//门店详情
    
    ProductOrderListViewActionTypeLoadData = 100,//加载数据
    
} ProductOrderListViewActionType;

@class ProductOrderListView;
@protocol ProductOrderListViewDelegate <NSObject>
- (void)productOrderListView:(ProductOrderListView *)view actionType:(ProductOrderListViewActionType)type value:(id)value;
@end

@interface ProductOrderListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<ProductOrderListViewDelegate> delegate;
@property (nonatomic, assign) NSArray *items;
- (void)beginRefreshing;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
