//
//  WholesaleOrderListView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleOrderListItem.h"

typedef enum : NSUInteger {
    WholesaleOrderListViewActionTypeConnectService = 1,//在线客服
    WholesaleOrderListViewActionTypeInvite = 2,//邀请好友
    WholesaleOrderListViewActionTypeShare = 3,//分享
    WholesaleOrderListViewActionTypePay = 4,//支付
    WholesaleOrderListViewActionTypeCountDownOver,//倒计时结束
    
    WholesaleOrderListViewActionTypeSegue = 50,
    WholesaleOrderListViewActionTypeLoadData,//加载数据
} WholesaleOrderListViewActionType;

@class WholesaleOrderListView;
@protocol WholesaleOrderListViewDelegate <NSObject>
- (void)wholesaleOrderListView:(WholesaleOrderListView *)view actionType:(WholesaleOrderListViewActionType)type value:(id)value;
@end

@interface WholesaleOrderListView : UIView
@property (nonatomic, strong) NSArray<WholesaleOrderListItem *> *items;
@property (nonatomic, weak) id<WholesaleOrderListViewDelegate> delegate;
@property (nonatomic, assign) BOOL noMoreOrderListData;
@property (nonatomic, assign) BOOL noMoreRecommendData;
- (void)beginRefreshing;
- (void)reloadData;
- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend;
@end
