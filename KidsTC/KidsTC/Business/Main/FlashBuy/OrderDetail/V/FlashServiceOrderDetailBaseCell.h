//
//  FlashServiceOrderDetailBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashServiceOrderDetailModel.h"

typedef enum : NSUInteger {
    FlashServiceOrderDetailBaseCellActionTypeService,
    FlashServiceOrderDetailBaseCellActionTypeStore,
    FlashServiceOrderDetailBaseCellActionTypeReload,
    FlashServiceOrderDetailBaseCellActionTypeContact,
    FlashServiceOrderDetailBaseCellActionTypeBooking,
    FlashServiceOrderDetailBaseCellActionTypeBookingMustEdit
} FlashServiceOrderDetailBaseCellActionType;

@class FlashServiceOrderDetailBaseCell;
@protocol FlashServiceOrderDetailBaseCellDelegate <NSObject>

- (void)flashServiceOrderDetailBaseCell:(FlashServiceOrderDetailBaseCell *)cell actionType:(FlashServiceOrderDetailBaseCellActionType)type;

@end

@interface FlashServiceOrderDetailBaseCell : UITableViewCell
@property (nonatomic, weak) FlashServiceOrderDetailData *data;
@property (nonatomic, weak) id<FlashServiceOrderDetailBaseCellDelegate> delegate;
@end
