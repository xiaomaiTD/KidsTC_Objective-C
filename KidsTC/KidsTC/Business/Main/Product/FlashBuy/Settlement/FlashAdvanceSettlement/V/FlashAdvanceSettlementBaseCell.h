//
//  FlashAdvanceSettlementBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSettlementModel.h"

typedef enum : NSUInteger {
    FlashAdvanceSettlementBaseCellActionTypeTipAddress=1,
    FlashAdvanceSettlementBaseCellActionTypeAddress,
    FlashAdvanceSettlementBaseCellActionTypeStoreInfo,
    FlashAdvanceSettlementBaseCellActionTypePayType,
    FlashAdvanceSettlementBaseCellActionTypeCheckRule,
    FlashAdvanceSettlementBaseCellActionTypeReadRule
} FlashAdvanceSettlementBaseCellActionType;

@class FlashAdvanceSettlementBaseCell;
@protocol FlashAdvanceSettlementBaseCellDelegate <NSObject>
- (void)flashAdvanceSettlementBaseCell:(FlashAdvanceSettlementBaseCell *)cell actionType:(FlashAdvanceSettlementBaseCellActionType)type value:(id)value;
@end

@interface FlashAdvanceSettlementBaseCell : UITableViewCell
@property (nonatomic, weak) FlashSettlementData *data;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) id<FlashAdvanceSettlementBaseCellDelegate> delegate;
@end
