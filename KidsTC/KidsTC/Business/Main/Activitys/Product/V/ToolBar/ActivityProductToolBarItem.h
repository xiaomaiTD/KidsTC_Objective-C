//
//  ActivityProductToolBarItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductTabItem.h"

@class ActivityProductToolBarItem;
@protocol ActivityProductToolBarItemDelegate <NSObject>
- (void)didClickActivityProductToolBarItem:(ActivityProductToolBarItem *)item;
@end

@interface ActivityProductToolBarItem : UIView
@property (nonatomic, strong) ActivityProductTabItem *item;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, weak) id<ActivityProductToolBarItemDelegate> delegate;
@end
