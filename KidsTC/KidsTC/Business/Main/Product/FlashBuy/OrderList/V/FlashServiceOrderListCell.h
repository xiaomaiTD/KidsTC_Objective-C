//
//  FlashServiceOrderListCell.h
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashServiceOrderListModel.h"

typedef enum : NSUInteger {
    FlashServiceOrderListCellActionTypeProductDetail=1,
    FlashServiceOrderListCellActionTypeLinkAction,
    FlashServiceOrderListCellActionTypeReload,
} FlashServiceOrderListCellActionType;

@class FlashServiceOrderListCell;
@protocol FlashServiceOrderListCellDelegate <NSObject>
- (void)flashServiceOrderListCell:(FlashServiceOrderListCell *)cell actionType:(FlashServiceOrderListCellActionType)type;
@end

@interface FlashServiceOrderListCell : UITableViewCell
@property (nonatomic, weak) FlashServiceOrderListItem *item;
@property (nonatomic, weak) id<FlashServiceOrderListCellDelegate> delegate;
@end
