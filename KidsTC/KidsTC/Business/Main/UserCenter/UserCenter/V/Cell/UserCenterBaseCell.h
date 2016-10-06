//
//  UserCenterBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterModel.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"

typedef enum : NSUInteger {
    UserCenterCellActionTypeUnLogin,
    UserCenterCellActionTypeHasLogin,
    UserCenterCellActionTypeMyCollection,
    UserCenterCellActionTypeSignup,
    UserCenterCellActionTypeBrowHistory,
    UserCenterCellActionTypeAllOrder,
    UserCenterCellActionTypeWaitPay,
    UserCenterCellActionTypeWaitUse,
    UserCenterCellActionTypeMyComment,
    UserCenterCellActionTypeRefund,
    UserCenterCellActionTypeCoupon,
    UserCenterCellActionTypePointment,
    UserCenterCellActionTypeCarrotHistory,
    UserCenterCellActionTypeInvite,
    UserCenterCellActionTypeFlashBy,
    UserCenterCellActionTypeHeadLine,
    UserCenterCellActionTypeConsult,
    UserCenterCellActionTypeContact,
    UserCenterCellActionTypeBanners,
    UserCenterCellActionTypeProduct
} UserCenterCellActionType;

@class UserCenterBaseCell;
@protocol UserCenterBaseCellDelegate <NSObject>
- (void)userCenterCell:(UserCenterBaseCell *)cell actionType:(UserCenterCellActionType)type addIndex:(NSUInteger)index;
@end

@interface UserCenterBaseCell : UITableViewCell
@property (nonatomic, weak) UserCenterModel *model;
@property (nonatomic, weak) id<UserCenterBaseCellDelegate> delegate;
@end
