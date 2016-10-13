//
//  TCHomeBaseTableViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHomeFloor.h"

typedef enum : NSUInteger {
    TCHomeBaseTableViewCellActionTypeSegue = 1
} TCHomeBaseTableViewCellActionType;
@class TCHomeBaseTableViewCell;

@protocol TCHomeBaseTableViewCellDelegate <NSObject>
- (void)tcHomeBaseTableViewCell:(TCHomeBaseTableViewCell *)cell actionType:(TCHomeBaseTableViewCellActionType)type value:(id)value;
@end

@interface TCHomeBaseTableViewCell : UITableViewCell
@property (nonatomic, strong) TCHomeFloor *floor;
@property (nonatomic, weak) id<TCHomeBaseTableViewCellDelegate> delegate;
@end
