//
//  NearbyCalendarView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"

typedef enum : NSUInteger {
    NearbyCalendarViewActionTypeDidSelectDate = 1,
    NearbyCalendarViewActionTypeDidSelectCategory = 2,
    NearbyCalendarViewActionTypeLike = 6,
    NearbyCalendarViewActionTypeSegue = 7,
    NearbyCalendarViewActionTypeLoadData = 8,
} NearbyCalendarViewActionType;

@class NearbyCalendarView;
@protocol NearbyCalendarViewDelegate <NSObject>
- (void)nearbyCalendarView:(NearbyCalendarView *)view actionType:(NearbyCalendarViewActionType)type value:(id)value;
@end

@interface NearbyCalendarView : UIView
@property (nonatomic, weak) id<NearbyCalendarViewDelegate> delegate;
@property (nonatomic, strong) NearbyData *data;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
