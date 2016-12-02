//
//  NearbyCalendarToolBarCategoryView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyCalendarToolBarCategoryItem.h"

@class NearbyCalendarToolBarCategoryView;
@protocol NearbyCalendarToolBarCategoryViewDelegate <NSObject>
- (void)nearbyCalendarToolBarCategoryView:(NearbyCalendarToolBarCategoryView *)view didSelectItem:(NearbyCalendarToolBarCategoryItem *)item;
@end

@interface NearbyCalendarToolBarCategoryView : UIView
@property (nonatomic, weak) id<NearbyCalendarToolBarCategoryViewDelegate> delegate;
- (CGFloat)contentHeight;
@end
