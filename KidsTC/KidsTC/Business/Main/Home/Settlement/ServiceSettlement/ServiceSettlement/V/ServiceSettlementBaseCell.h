//
//  ServiceSettlementBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceSettlementModel.h"

typedef enum : NSUInteger {
    ServiceSettlementBaseCellActionTypeTipAddress=1,
    ServiceSettlementBaseCellActionTypeAddress,
    ServiceSettlementBaseCellActionTypeStore,
    ServiceSettlementBaseCellActionTypeCoupon,
    ServiceSettlementBaseCellActionTypeScore,
    ServiceSettlementBaseCellActionTypeChangePayType,
    ServiceSettlementBaseCellActionTypeBuyNumDidChange,
} ServiceSettlementBaseCellActionType;

@class ServiceSettlementBaseCell;
@protocol ServiceSettlementBaseCellDelegate <NSObject>
- (void)serviceSettlementBaseCell:(ServiceSettlementBaseCell *)cell actionType:(ServiceSettlementBaseCellActionType)type value:(id)value;
@end

@interface ServiceSettlementBaseCell : UITableViewCell
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) ServiceSettlementDataItem *item;
@property (nonatomic, weak) id<ServiceSettlementBaseCellDelegate> delegate;
@end
