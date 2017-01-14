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

typedef enum : NSUInteger {
    ActivityProductToolBarActionTypeSegue = 1,
} ActivityProductToolBarActionType;

@class ActivityProductToolBar;
@protocol ActivityProductToolBarDelegate <NSObject>
- (void)activityProductToolBar:(ActivityProductToolBar *)toolBar actionType:(ActivityProductToolBarActionType)type value:(id)value;
@end

@interface ActivityProductToolBar : UIView
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, weak) id<ActivityProductToolBarDelegate> delegate;
@end
