//
//  AutoRollView.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterProductAutoRollCell.h"

@class UserCenterProductAutoRollView;
@protocol UserCenterProductAutoRollViewDelegate<NSObject>
-(void)didSelectPageAtIndex:(NSUInteger)index;
@end
@interface UserCenterProductAutoRollView : UIView
@property (nonatomic, assign) UserCenterHotProductType productType;
@property (nonatomic, strong) NSArray<UserCenterProductLsItem *> *originalItems;
@property (nonatomic,weak)id<UserCenterProductAutoRollViewDelegate> delegate;
@end
