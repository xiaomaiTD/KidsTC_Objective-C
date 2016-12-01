//
//  NearbyFilterToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NearbyFilterToolBarActionTypeDate = 1,
    NearbyFilterToolBarActionTypeCategory,
} NearbyFilterToolBarActionType;

@class NearbyFilterToolBar;
@protocol NearbyFilterToolBarDelegate <NSObject>
- (void)nearbyFilterToolBar:(NearbyFilterToolBar *)toolBar actionType:(NearbyFilterToolBarActionType)type value:(id)value;
@end

@interface NearbyFilterToolBar : UIView
@property (nonatomic, weak) id<NearbyFilterToolBarDelegate> delegate;
@end
