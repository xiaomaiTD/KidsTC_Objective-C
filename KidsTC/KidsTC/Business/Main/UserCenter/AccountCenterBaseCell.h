//
//  AccountCenterBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AccountCenterCellActionTypeCollectionProduct = 1,
    AccountCenterCellActionTypeCollectionStore,
    AccountCenterCellActionTypeCollectionContent,
    AccountCenterCellActionTypeCollectionPeople,
} AccountCenterCellActionType;

@class AccountCenterBaseCell;
@protocol AccountCenterBaseCellDelegate <NSObject>
- (void)accountCenterBaseCell:(AccountCenterBaseCell *)cell actionType:(AccountCenterCellActionType)type value:(id)value;
@end

@interface AccountCenterBaseCell : UITableViewCell
@property (nonatomic, weak) id<AccountCenterBaseCellDelegate> delegate;
@end
