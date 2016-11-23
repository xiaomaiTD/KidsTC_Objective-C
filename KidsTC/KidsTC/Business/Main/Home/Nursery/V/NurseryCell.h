//
//  NurseryCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NurseryItem.h"

typedef enum : NSUInteger {
    NurseryCellActionTypeNearby = 1,
    NurseryCellActionTypeRoute,
} NurseryCellActionType;

@class NurseryCell;
@protocol NurseryCellDelegate <NSObject>
- (void)nurseryCell:(NurseryCell *)cell actionType:(NurseryCellActionType)type value:(id)value;
@end

@interface NurseryCell : UITableViewCell
@property (nonatomic, strong) NurseryItem *item;
@property (nonatomic, weak) id<NurseryCellDelegate> delegate;
@end
