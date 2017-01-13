//
//  ActivityProductToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductContent.h"

extern CGFloat const kActivityProductToolBarH;

@class ActivityProductToolBar;
@protocol ActivityProductToolBarDelegate <NSObject>
- (void)activityProductToolBar:(ActivityProductToolBar *)toolBar didSelectItem:(ActivityProductTabItem *)item index:(NSInteger)index;
@end

@interface ActivityProductToolBar : UIView
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, weak) id<ActivityProductToolBarDelegate> delegate;
@end
