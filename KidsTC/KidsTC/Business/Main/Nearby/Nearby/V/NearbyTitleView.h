//
//  NearbyTitleView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyTitleViewActionTypeAddress = 1,
    NearbyTitleViewActionTypeSearch,
} NearbyTitleViewActionType;

@class NearbyTitleView;
@protocol NearbyTitleViewDelegate <NSObject>
- (void)nearbyTitleView:(NearbyTitleView *)view actionType:(NearbyTitleViewActionType)type value:(id)value;
@end

@interface NearbyTitleView : UIView
@property (nonatomic, weak) id<NearbyTitleViewDelegate> delegate;
@end
