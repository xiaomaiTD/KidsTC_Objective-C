//
//  NearbyFilterView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyFilterViewActionTypeBack = 1,
    NearbyFilterViewActionTypeDidSelectDate,
    NearbyFilterViewActionTypeDidSelectCategory,
} NearbyFilterViewActionType;

@class NearbyFilterView;
@protocol NearbyFilterViewDelegate <NSObject>
- (void)nearbyFilterView:(NearbyFilterView *)view actionType:(NearbyFilterViewActionType)type value:(id)value;
@end

@interface NearbyFilterView : UIView
@property (nonatomic, weak) id<NearbyFilterViewDelegate> delegate;
@end
