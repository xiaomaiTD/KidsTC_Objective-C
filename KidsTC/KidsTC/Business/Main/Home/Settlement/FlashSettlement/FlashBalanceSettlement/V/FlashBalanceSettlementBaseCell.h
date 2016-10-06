//
//  FlashBalanceSettlementBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSettlementModel.h"

typedef enum : NSUInteger {
    FlashBalanceSettlementBaseCellActionTypeScore=1,
    FlashBalanceSettlementBaseCellActionTypePayType,
} FlashBalanceSettlementBaseCellActionType;

@class FlashBalanceSettlementBaseCell;
@protocol FlashBalanceSettlementBaseCellDelegate <NSObject>
- (void)flashBalanceSettlementBaseCell:(FlashBalanceSettlementBaseCell *)cell actionType:(FlashBalanceSettlementBaseCellActionType)type value:(id)value;
@end

@interface FlashBalanceSettlementBaseCell : UITableViewCell
@property (nonatomic, weak) FlashSettlementData *data;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) id<FlashBalanceSettlementBaseCellDelegate> delegate;
@end
