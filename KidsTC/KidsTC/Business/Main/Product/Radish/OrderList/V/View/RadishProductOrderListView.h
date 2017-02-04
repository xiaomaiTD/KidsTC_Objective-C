//
//  RadishOrderListView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductOrderListItem.h"

#define RadishProductOrderListPageCount 10

typedef enum : NSUInteger {
    
    RadishProductOrderListViewActionTypePay = 1,/// 付款
    RadishProductOrderListViewActionTypeCancelOrder = 2,/// 取消订单
    RadishProductOrderListViewActionTypeConnectService = 3,/// 联系客服
    RadishProductOrderListViewActionTypeConnectSupplier = 4,/// 联系商家
    RadishProductOrderListViewActionTypeConsumeCode = 5,/// 取票码
    RadishProductOrderListViewActionTypeReserve = 6,/// 我要预约
    RadishProductOrderListViewActionTypeCancelTip = 7,/// 取消提醒
    RadishProductOrderListViewActionTypeWantTip = 8,/// 活动提醒
    RadishProductOrderListViewActionTypeReminder = 9,/// 我要催单
    RadishProductOrderListViewActionTypeConfirmDeliver = 10,/// 确认收货
    RadishProductOrderListViewActionTypeEvaluate = 11,/// 评价
    RadishProductOrderListViewActionTypeBuyAgain = 12,/// 再次购买
    RadishProductOrderListViewActionTypeComplaint = 13,/// 投诉
    RadishProductOrderListViewActionTypeRefund = 14,//申请售后
    RadishProductOrderListViewActionTypeCountDownOver,//倒计时结束
    
    RadishProductOrderListViewActionTypeStore = 50,//门店详情
    RadishProductOrderListViewActionTypeSegue = 51,//通用跳转
    RadishProductOrderListViewActionTypeCall = 52,//打电话
    
    RadishProductOrderListViewActionTypeLoadData = 100,//加载数据
    
} RadishProductOrderListViewActionType;

@class RadishProductOrderListView;
@protocol RadishProductOrderListViewDelegate <NSObject>
- (void)radishProductOrderListView:(RadishProductOrderListView *)view actionType:(RadishProductOrderListViewActionType)type value:(id)value;
@end

@interface RadishProductOrderListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<RadishProductOrderListViewDelegate> delegate;
@property (nonatomic, strong) NSArray<RadishProductOrderListItem *> *items;
@property (nonatomic, assign) BOOL noMoreOrderListData;
@property (nonatomic, assign) BOOL noMoreRecommendData;
- (void)beginRefreshing;
- (void)reloadData;
- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend;
@end
