//
//  NearbyCalendarToolBarDateView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearbyCalendarToolBarDateView;
@protocol NearbyCalendarToolBarDateViewDelegate <NSObject>
- (void)nearbyCalendarToolBarDateView:(NearbyCalendarToolBarDateView *)view didSelectDate:(NSDate *)date;
@end

@interface NearbyCalendarToolBarDateView : UIView
@property (nonatomic, weak) id<NearbyCalendarToolBarDateViewDelegate> delegate;
@end
