//
//  AccountCenterHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCenterModel.h"

typedef enum : NSUInteger {
    AccountCenterHeaderActionTypeSoftwareSetting=1,
    AccountCenterHeaderActionTypeMessageCenter,
    AccountCenterHeaderActionTypeLogin,
    AccountCenterHeaderActionTypeAccountSetting,
    AccountCenterHeaderActionTypeRole,
} AccountCenterHeaderActionType;

@class AccountCenterHeader;
@protocol AccountCenterHeaderDelegate <NSObject>
- (void)accountCenterHeader:(AccountCenterHeader *)header actionType:(AccountCenterHeaderActionType)type value:(id)value;
@end

@interface AccountCenterHeader : UIView
@property (nonatomic, strong) AccountCenterModel *model;
@property (nonatomic, weak) id<AccountCenterHeaderDelegate> delegate;
@end
