//
//  NearbyFilterToolBarItemView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyFilterToolBarItemView : UIView
@property (nonatomic, assign) UIControlState state;
@property (nonatomic, copy) void(^actionBlock)(NearbyFilterToolBarItemView *itemView);
- (void)setTitle:(NSString *)title;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setIconImage:(UIImage *)image forState:(UIControlState)state;
- (void)setArrowImage:(UIImage *)image forState:(UIControlState)state;
@end
