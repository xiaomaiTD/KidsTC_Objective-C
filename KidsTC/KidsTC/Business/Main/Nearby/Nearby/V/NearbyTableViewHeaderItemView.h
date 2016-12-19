//
//  NearbyTableViewHeaderItemView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyPlaceInfoData.h"

@class NearbyTableViewHeaderItemView;
@protocol NearbyTableViewHeaderItemViewDelegate <NSObject>
- (void)nearbyTableViewHeaderItemView:(NearbyTableViewHeaderItemView *)view actionType:(NurseryType)type value:(id)value;
@end

@interface NearbyTableViewHeaderItemView : UIView
@property (nonatomic, weak) id<NearbyTableViewHeaderItemViewDelegate> delegate;
@property (nonatomic, strong) NearbyPlaceInfoData *data;
@end
