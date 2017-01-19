//
//  WholesaleSettlementBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleSettlementData.h"

typedef enum : NSUInteger {
    WholesaleSettlementBaseCellActionTypeSelectPlace = 1,//切换地址
    WholesaleSettlementBaseCellActionTypeRule,//查看活动规则
    WholesaleSettlementBaseCellActionTypeSelectDate,//选择时间
    WholesaleSettlementBaseCellActionTypeAddress,//选择用户收货地址
    WholesaleSettlementBaseCellActionTypeAddressTip,//直接添加用户收货地址
} WholesaleSettlementBaseCellActionType;

@class WholesaleSettlementBaseCell;
@protocol WholesaleSettlementBaseCellDelegate <NSObject>
- (void)wholesaleSettlementBaseCell:(WholesaleSettlementBaseCell *)cell actionType:(WholesaleSettlementBaseCellActionType)type value:(id)value;
@end

@interface WholesaleSettlementBaseCell : UITableViewCell
@property (nonatomic, strong) WholesaleSettlementData *data;
@property (nonatomic, weak) id<WholesaleSettlementBaseCellDelegate> delegate;
@end
