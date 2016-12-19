//
//  NearbyTableViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyItem.h"

typedef enum : NSUInteger {
    NearbyTableViewCellActionTypeLike = 102,
} NearbyTableViewCellActionType;
@class NearbyTableViewCell;
@protocol NearbyTableViewCellDelegate <NSObject>
- (void)nearbyTableViewCell:(NearbyTableViewCell *)cell actionType:(NearbyTableViewCellActionType)type value:(id)value;
@end

@interface NearbyTableViewCell : UITableViewCell
@property (nonatomic, weak) NearbyItem *item;
@property (nonatomic, weak) id<NearbyTableViewCellDelegate> delegate;
@end
