//
//  WelfareStoreLoveHouseCell.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareStoreModel.h"

typedef enum : NSUInteger {
    WelfareStoreLoveHouseCellActionTypeGoto,
    WelfareStoreLoveHouseCellActionTypeNearby,
} WelfareStoreLoveHouseCellActionType;

@class WelfareStoreLoveHouseCell;
@protocol WelfareStoreLoveHouseCellDelegate <NSObject>
- (void)welfareStoreLoveHouseCell:(WelfareStoreLoveHouseCell *)cell actionType:(WelfareStoreLoveHouseCellActionType)type;
@end

@interface WelfareStoreLoveHouseCell : UITableViewCell
@property (nonatomic, strong) WelfareStoreItem *item;
@property (nonatomic, weak) id<WelfareStoreLoveHouseCellDelegate> delegate;
@end
