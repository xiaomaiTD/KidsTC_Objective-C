//
//  NearbyTableViewHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kNearbyTableViewHeaderH;

typedef enum : NSUInteger {
    NearbyTableViewHeaderActionTypeNursery = 1,
    NearbyTableViewHeaderActionTypeExhibition,
    NearbyTableViewHeaderActionTypeCalendar,
} NearbyTableViewHeaderActionType;

@class NearbyTableViewHeader;
@protocol NearbyTableViewHeaderDelegate <NSObject>
- (void)nearbyTableViewHeader:(NearbyTableViewHeader *)header actionType:(NearbyTableViewHeaderActionType)type value:(id)value;
@end

@interface NearbyTableViewHeader : UIView
@property (nonatomic, weak) id<NearbyTableViewHeaderDelegate> delegate;
@end
