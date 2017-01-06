//
//  RadishSettlementView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RadishSettlementData.h"

typedef enum : NSUInteger {
    RadishSettlementViewActionTypeSelectStore = 1,//切换门店
    RadishSettlementViewActionTypeSelectPlace,//切换地址
    RadishSettlementViewActionTypeRule,//查看活动规则
    RadishSettlementViewActionTypePlaceOrder = 50,//下单
} RadishSettlementViewActionType;

@class RadishSettlementView;
@protocol RadishSettlementViewDelegate <NSObject>
- (void)radishSettlementView:(RadishSettlementView *)view actionType:(RadishSettlementViewActionType)type value:(id)value;
@end

@interface RadishSettlementView : UIView
@property (nonatomic, strong) RadishSettlementData *data;
@property (nonatomic, weak) id<RadishSettlementViewDelegate> delegate;
- (void)reloadData;
@end
