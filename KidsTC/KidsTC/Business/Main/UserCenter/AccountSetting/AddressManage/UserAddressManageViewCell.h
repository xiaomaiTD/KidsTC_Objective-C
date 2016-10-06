//
//  UserAddressManageViewCell.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddressManageModel.h"
#import "UserAddressManageViewController.h"

typedef enum : NSUInteger {
    UserAddressManageViewCellActionTypeEdit,
    UserAddressManageViewCellActionTypeDelet
} UserAddressManageViewCellActionType;

@class UserAddressManageViewCell;
@protocol UserAddressManageViewCellDelegate <NSObject>
- (void)userAddressManageViewCell:(UserAddressManageViewCell *)cell actionType:(UserAddressManageViewCellActionType)type;
@end

@interface UserAddressManageViewCell : UITableViewCell
@property (nonatomic, assign) UserAddressManageFromType fromeType;
@property (nonatomic, strong) UserAddressManageDataItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<UserAddressManageViewCellDelegate> delegate;
@end
