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
    RadishSettlementViewActionTypeTipAddress = 1,//添加收货地址
    RadishSettlementViewActionTypeAddress,//切换收货地址
    RadishSettlementViewActionTypeSelectStore,//切换活动门店
    RadishSettlementViewActionTypeSelectPlace,//切换活动地址
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
- (void)scrollToUserRemark;
@end
