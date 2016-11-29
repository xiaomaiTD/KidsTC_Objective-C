//
//  CouponListUnusedCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponListItem.h"

typedef enum : NSUInteger {
    CouponListUnusedCellActionTypeOpearteTip = 1,
    CouponListUnusedCellActionTypeUseCoupon,
} CouponListUnusedCellActionType;

@class CouponListUnusedCell;
@protocol CouponListUnusedCellDelegate <NSObject>
- (void)couponListUnusedCell:(CouponListUnusedCell *)cell actionType:(CouponListUnusedCellActionType)type value:(id)value;
@end

@interface CouponListUnusedCell : UITableViewCell
@property (nonatomic, strong) CouponListItem *item;
@property (nonatomic, weak) id<CouponListUnusedCellDelegate> delegate;
@end
