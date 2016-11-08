//
//  AccountCenterData.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterUserCount.h"
#import "AccountCenterInvite.h"
#import "AccountCenterRadish.h"
#import "AccountCenterExHistory.h"
#import "AccountCenterFsList.h"
#import "AccountCenterUserInfo.h"
#import "AccountCenterConfig.h"

@interface AccountCenterData : NSObject
@property (nonatomic, strong) AccountCenterUserCount *userCount;
@property (nonatomic, strong) AccountCenterInvite *invite;
@property (nonatomic, strong) AccountCenterRadish *radish;
@property (nonatomic, strong) AccountCenterExHistory *exHistory;
@property (nonatomic, strong) AccountCenterFsList *fsList;
@property (nonatomic, strong) NSString *kfMobile;
@property (nonatomic, strong) AccountCenterUserInfo *userInfo;
@property (nonatomic, strong) AccountCenterConfig *config;
@end
