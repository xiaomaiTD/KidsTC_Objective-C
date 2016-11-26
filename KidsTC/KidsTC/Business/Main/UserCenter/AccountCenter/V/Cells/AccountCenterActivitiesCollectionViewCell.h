//
//  AccountCenterActivitiesCollectionViewCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCenterActivity.h"

@interface AccountCenterActivitiesCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) AccountCenterActivity *activity;
@property (nonatomic, copy) void(^actionBlock)(SegueModel *segueModel);
@end
