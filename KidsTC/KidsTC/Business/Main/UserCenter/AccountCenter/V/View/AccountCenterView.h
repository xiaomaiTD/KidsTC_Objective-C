//
//  AccountCenterView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCenterModel.h"

typedef enum : NSUInteger {
    
    AccountCenterViewActionTypeSoftwareSetting = 1,
    AccountCenterViewActionTypeMessageCenter,
    AccountCenterViewActionTypeLogin,
    AccountCenterViewActionTypeAccountSetting,
    AccountCenterViewActionTypeRole,
    
    AccountCenterViewActionTypeCollectionProduct = 100,
    AccountCenterViewActionTypeCollectionStore,
    AccountCenterViewActionTypeCollectionContent,
    AccountCenterViewActionTypeCollectionPeople,
    
    AccountCenterViewActionTypeAllOrder,
    AccountCenterViewActionTypeWaitPay,
    AccountCenterViewActionTypeWaitUse,
    AccountCenterViewActionTypeWaitReceipt,
    AccountCenterViewActionTypeWaitComment,
    AccountCenterViewActionTypeRefund,
    
    AccountCenterViewActionTypeScore,
    AccountCenterViewActionTypeRadish,
    AccountCenterViewActionTypeCoupon,
    AccountCenterViewActionTypeECard,
    AccountCenterViewActionTypeBalance,
    
    AccountCenterViewActionTypeHistory,
    AccountCenterViewActionTypeRadishMall,
    AccountCenterViewActionTypeMyFlash,
    AccountCenterViewActionTypeMyAppoinment,
    AccountCenterViewActionTypeShareMakeMoney,
    AccountCenterViewActionTypeBringUpHeadline,
    AccountCenterViewActionTypeCustomerServices,
    AccountCenterViewActionTypeOpinion,
    
    AccountCenterViewActionTypeSegue,
    
    AccountCenterViewActionTypeLoadData,
    
} AccountCenterViewActionType;

@class AccountCenterView;
@protocol AccountCenterViewDelegate <NSObject>
- (void)accountCenterView:(AccountCenterView *)view actionType:(AccountCenterViewActionType)type value:(id)value;
@end

@interface AccountCenterView : UIView
@property (nonatomic, strong) AccountCenterModel *model;
@property (nonatomic, weak) id<AccountCenterViewDelegate> delegate;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
