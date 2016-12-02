//
//  NearbyView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyViewActionTypeNursery = 1,
    NearbyViewActionTypeExhibition,
    NearbyViewActionTypeCalendar,
} NearbyViewActionType;
@class NearbyView;
@protocol NearbyViewDelegate <NSObject>
- (void)nearbyView:(NearbyView *)view actionType:(NearbyViewActionType)type value:(id)value;
@end
@interface NearbyView : UIView
@property (nonatomic, weak) id<NearbyViewDelegate> delegate;
@end
