//
//  NearbyFilterToolBarCategoryView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyFilterToolBarCategoryItem.h"

@class NearbyFilterToolBarCategoryView;
@protocol NearbyFilterToolBarCategoryViewDelegate <NSObject>
- (void)nearbyFilterToolBarCategoryView:(NearbyFilterToolBarCategoryView *)view didSelectItem:(NearbyFilterToolBarCategoryItem *)item;
@end

@interface NearbyFilterToolBarCategoryView : UIView
@property (nonatomic, weak) id<NearbyFilterToolBarCategoryViewDelegate> delegate;
- (CGFloat)contentHeight;
@end
