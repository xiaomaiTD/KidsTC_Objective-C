//
//  RadishSettlementBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishSettlementData.h"

typedef enum : NSUInteger {
    RadishSettlementBaseCellActionTypeTipAddress = 1,//添加收货地址
    RadishSettlementBaseCellActionTypeAddress,//切换收货地址
    RadishSettlementBaseCellActionTypeSelectStore,//切换活动门店
    RadishSettlementBaseCellActionTypeSelectPlace,//切换活动地址
} RadishSettlementBaseCellActionType;

@class RadishSettlementBaseCell;
@protocol RadishSettlementBaseCellDelegate <NSObject>
- (void)radishSettlementBaseCell:(RadishSettlementBaseCell *)cell actionType:(RadishSettlementBaseCellActionType)type value:(id)value;
@end

@interface RadishSettlementBaseCell : UITableViewCell
@property (nonatomic, strong) RadishSettlementData *data;
@property (nonatomic, weak) id<RadishSettlementBaseCellDelegate> delegate;
@end
