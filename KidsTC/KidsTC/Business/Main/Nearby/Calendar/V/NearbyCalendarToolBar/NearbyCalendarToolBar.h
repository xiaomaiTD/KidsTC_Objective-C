//
//  NearbyCalendarToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyCalendarToolBarActionTypeDidSelectDate = 1,
    NearbyCalendarToolBarActionTypeDidSelectCategory,
} NearbyCalendarToolBarActionType;

extern CGFloat const kNearbyCalendarToolBarH;

@class NearbyCalendarToolBar;
@protocol NearbyCalendarToolBarDelegate <NSObject>
- (void)nearbyCalendarToolBar:(NearbyCalendarToolBar *)toolBar actionType:(NearbyCalendarToolBarActionType)type value:(id)value;
@end

@interface NearbyCalendarToolBar : UIView
@property (nonatomic, weak) id<NearbyCalendarToolBarDelegate> delegate;
@end
