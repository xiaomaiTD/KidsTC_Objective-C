//
//  NearbyFilterToolBarDateView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearbyFilterToolBarDateView;
@protocol NearbyFilterToolBarDateViewDelegate <NSObject>
- (void)nearbyFilterToolBarDateView:(NearbyFilterToolBarDateView *)view didSelectDate:(NSDate *)date;
@end

@interface NearbyFilterToolBarDateView : UIView
@property (nonatomic, weak) id<NearbyFilterToolBarDateViewDelegate> delegate;
@end
