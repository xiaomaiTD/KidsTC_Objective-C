//
//  ProductOrderFreeDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeDetailData.h"
#import "ProductOrderFreeDetailLotteryItem.h"

typedef enum : NSUInteger {
    ProductOrderFreeDetailViewActionTypePay = 1,/// 付款
    ProductOrderFreeDetailViewActionTypeCancelOrder = 2,/// 取消订单
    ProductOrderFreeDetailViewActionTypeConnectService = 3,/// 联系客服
    ProductOrderFreeDetailViewActionTypeConnectSupplier = 4,/// 联系商家
    ProductOrderFreeDetailViewActionTypeConsumeCode = 5,/// 取票码
    ProductOrderFreeDetailViewActionTypeReserve = 6,/// 我要预约
    ProductOrderFreeDetailViewActionTypeCancelTip = 7,/// 取消提醒
    ProductOrderFreeDetailViewActionTypeWantTip = 8,/// 活动提醒
    ProductOrderFreeDetailViewActionTypeReminder = 9,/// 我要催单
    ProductOrderFreeDetailViewActionTypeConfirmDeliver = 10,/// 确认收货
    ProductOrderFreeDetailViewActionTypeEvaluate = 11,/// 评价
    ProductOrderFreeDetailViewActionTypeBuyAgain = 12,/// 再次购买
    ProductOrderFreeDetailViewActionTypeComplaint = 13,/// 投诉
    ProductOrderFreeDetailViewActionTypeRefund = 14,//申请售后
    ProductOrderFreeDetailViewActionTypeCountDownOver,//倒计时结束
    
    ProductOrderFreeDetailViewActionTypeSegue = 50,
    ProductOrderFreeDetailViewActionTypeStore,
    ProductOrderFreeDetailViewActionTypeAddress,
    ProductOrderFreeDetailViewActionTypeDate,
    ProductOrderFreeDetailViewActionTypeMoreLottery,
    ProductOrderFreeDetailViewActionTypeShowRule,
} ProductOrderFreeDetailViewActionType;

@class ProductOrderFreeDetailView;
@protocol ProductOrderFreeDetailViewDelegate <NSObject>
- (void)productOrderFreeDetailView:(ProductOrderFreeDetailView *)view actionType:(ProductOrderFreeDetailViewActionType)type value:(id)value;
@end

@interface ProductOrderFreeDetailView : UIView
@property (nonatomic, weak) id<ProductOrderFreeDetailViewDelegate> delegate;
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailLotteryItem* > *lotteryData;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
- (void)reloadInfoData;
- (void)reloadLotteryData:(NSInteger)count;
@end
