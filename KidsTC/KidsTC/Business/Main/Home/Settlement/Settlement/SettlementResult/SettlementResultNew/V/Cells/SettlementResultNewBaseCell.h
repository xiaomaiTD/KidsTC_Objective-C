//
//  SettlementResultNewBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SettlementResultNewBaseCellActionTypeOrderDetail = 1,
    SettlementResultNewBaseCellActionTypeGoHome,
} SettlementResultNewBaseCellActionType;

@class SettlementResultNewBaseCell;
@protocol SettlementResultNewBaseCellDelegate <NSObject>
- (void)settlementResultNewBaseCell:(SettlementResultNewBaseCell *)cell actionType:(SettlementResultNewBaseCellActionType)type value:(id)value;
@end

@interface SettlementResultNewBaseCell : UITableViewCell
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, weak) id<SettlementResultNewBaseCellDelegate> delegate;
@end
