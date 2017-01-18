//
//  WholesaleSettlementView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WholesaleSettlementData.h"

typedef enum : NSUInteger {
    WholesaleSettlementViewActionTypeSelectPlace = 1,//切换地址
    WholesaleSettlementViewActionTypeRule,//查看活动规则
    WholesaleSettlementViewActionTypeSelectDate,//选择时间
    WholesaleSettlementViewActionTypePlaceOrder = 50,//下单
} WholesaleSettlementViewActionType;

@class WholesaleSettlementView;
@protocol WholesaleSettlementViewDelegate <NSObject>
- (void)wholesaleSettlementView:(WholesaleSettlementView *)view actionType:(WholesaleSettlementViewActionType)type value:(id)value;
@end

@interface WholesaleSettlementView : UIView
@property (nonatomic, strong) WholesaleSettlementData *data;
@property (nonatomic, weak) id<WholesaleSettlementViewDelegate> delegate;
- (void)reloadData;
@end
