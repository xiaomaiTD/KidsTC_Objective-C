//
//  WholesalePickDateBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesalePickDateSKU.h"

typedef enum : NSUInteger {
    WholesalePickDateBaseCellActionTypeSelectTiem = 50,
} WholesalePickDateBaseCellActionType;

@class WholesalePickDateBaseCell;
@protocol WholesalePickDateBaseCellDelegate <NSObject>
- (void)wholesalePickDateBaseCell:(WholesalePickDateBaseCell *)cell actionType:(WholesalePickDateBaseCellActionType)type vlaue:(id)value;
@end

@interface WholesalePickDateBaseCell : UITableViewCell
@property (nonatomic, strong) WholesalePickDateSKU *sku;
@property (nonatomic, weak) id<WholesalePickDateBaseCellDelegate> delegate;
@end
