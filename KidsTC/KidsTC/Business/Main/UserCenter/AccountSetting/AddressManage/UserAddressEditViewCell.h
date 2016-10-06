//
//  UserAddressEditViewCell.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddressEditModel.h"

typedef enum : NSUInteger {
    UserAddressEditViewCellActionTypeSelect,
    UserAddressEditViewCellActionTypeSave,
    UserAddressEditViewCellActionTypeTapArea
} UserAddressEditViewCellActionType;

typedef enum : NSUInteger {
    UserAddressEditViewCellEditTypeName,
    UserAddressEditViewCellEditTypePhone,
    UserAddressEditViewCellEditTypeAddress
} UserAddressEditViewCellEditType;

@class UserAddressEditViewCell;
@protocol UserAddressEditViewCellDelegate <NSObject>
- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell actionType:(UserAddressEditViewCellActionType)type;
- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell endEditing:(NSString *)value type:(UserAddressEditViewCellEditType)type;
- (void)userAddressEditViewCell:(UserAddressEditViewCell *)cell switchOn:(BOOL)switchOn;
@end

@interface UserAddressEditViewCell : UITableViewCell
@property (nonatomic, weak) UserAddressEditModel *model;
@property (nonatomic, weak) id<UserAddressEditViewCellDelegate> delegate;
@end
