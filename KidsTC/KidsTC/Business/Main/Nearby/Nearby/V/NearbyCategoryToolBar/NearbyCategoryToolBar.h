//
//  NearbyCategoryToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyCategoryToolBarActionTypeDidSelectCategory = 200
} NearbyCategoryToolBarActionType;

@class NearbyCategoryToolBar;
@protocol NearbyCategoryToolBarDelegate <NSObject>
- (void)nearbyCategoryToolBar:(NearbyCategoryToolBar *)toolBar actionType:(NearbyCategoryToolBarActionType)type value:(id)value;
@end

@interface NearbyCategoryToolBar : UIView
@property (nonatomic, weak) id<NearbyCategoryToolBarDelegate> delegate;
- (void)showHide;
- (void)hide;
@end
