//
//  AutoRollView.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserCenterBannerAutoRoleCell.h"
@protocol AutoRollViewDelegate<NSObject>
-(void)didSelectPageAtIndex:(NSUInteger)index;
@end
@interface UserCenterBannerAutoRollView : UIView
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,weak)id<AutoRollViewDelegate> delegate;
@end
