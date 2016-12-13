//
//  NearbyTableViewHeaderItemView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NearbyTableViewHeaderActionTypeNursery = 1,
    NearbyTableViewHeaderActionTypeExhibition,
    NearbyTableViewHeaderActionTypeCalendar,
} NearbyTableViewHeaderActionType;

@class NearbyTableViewHeaderItemView;
@protocol NearbyTableViewHeaderItemViewDelegate <NSObject>
- (void)nearbyTableViewHeaderItemView:(NearbyTableViewHeaderItemView *)view actionType:(NearbyTableViewHeaderActionType)type value:(id)value;
@end

@interface NearbyTableViewHeaderItemView : UIView
@property (nonatomic, assign) NearbyTableViewHeaderActionType type;
@property (nonatomic, weak) id<NearbyTableViewHeaderItemViewDelegate> delegate;
@end
