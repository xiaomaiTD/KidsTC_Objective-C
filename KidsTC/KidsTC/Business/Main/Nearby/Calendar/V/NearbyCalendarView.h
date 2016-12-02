//
//  NearbyCalendarView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyCalendarViewActionTypeDidSelectDate = 1,
    NearbyCalendarViewActionTypeDidSelectCategory,
} NearbyCalendarViewActionType;

@class NearbyCalendarView;
@protocol NearbyCalendarViewDelegate <NSObject>
- (void)nearbyCalendarView:(NearbyCalendarView *)view actionType:(NearbyCalendarViewActionType)type value:(id)value;
@end

@interface NearbyCalendarView : UIView
@property (nonatomic, weak) id<NearbyCalendarViewDelegate> delegate;
@end
