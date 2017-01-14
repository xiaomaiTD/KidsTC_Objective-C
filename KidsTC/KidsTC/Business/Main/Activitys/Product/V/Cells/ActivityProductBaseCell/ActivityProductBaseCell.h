//
//  ActivityProductBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductFloorItem.h"

typedef enum : NSUInteger {
    ActivityProductBaseCellActionTypeSegue = 1,
    ActivityProductBaseCellActionTypeCoupon,
} ActivityProductBaseCellActionType;

@class ActivityProductBaseCell;
@protocol ActivityProductBaseCellDelegate <NSObject>
- (void)activityProductBaseCell:(ActivityProductBaseCell *)cell actionType:(ActivityProductBaseCellActionType)type value:(id)value;
@end

@interface ActivityProductBaseCell : UITableViewCell
@property (nonatomic, strong) ActivityProductFloorItem *floorItem;
@property (nonatomic, weak) id<ActivityProductBaseCellDelegate> delegate;
@end
