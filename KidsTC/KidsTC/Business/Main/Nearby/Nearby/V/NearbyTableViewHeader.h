//
//  NearbyTableViewHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyPlaceInfo.h"
#import "NearbyTableViewHeaderItemView.h"

extern CGFloat const kNearbyTableViewHeaderH;

@class NearbyTableViewHeader;
@protocol NearbyTableViewHeaderDelegate <NSObject>
- (void)nearbyTableViewHeader:(NearbyTableViewHeader *)header actionType:(NurseryType)type value:(id)value;
@end

@interface NearbyTableViewHeader : UIView
@property (nonatomic, weak) NearbyPlaceInfo *placeInfo;
@property (nonatomic, weak) id<NearbyTableViewHeaderDelegate> delegate;
@end
