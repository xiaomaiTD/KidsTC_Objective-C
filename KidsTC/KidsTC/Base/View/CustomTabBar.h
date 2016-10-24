//
//  CustomTabBar.h
//  KidsTC
//
//  Created by 詹平 on 16/4/10.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "TipButton.h"

@interface CustomTabBarButton : TipButton
@property (nonatomic, strong)TabBarItemElement *element;
@end

@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>
- (void)customTabBar:(CustomTabBar *)customTabBar didSelectElementType:(TabBarItemElementType)type;
@end
@interface CustomTabBar : UIView
@property (nonatomic, strong) NSMutableArray<CustomTabBarButton *> *btns;
@property (nonatomic, strong) NSArray<TabBarItemElement *> *elements;
@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;
- (void)selectIndex:(NSUInteger)index;
- (void)makeBadgeIndex:(NSUInteger)index type:(TipButtonBadgeType)type value:(NSUInteger)value;
- (void)clearBadgeIndex:(NSUInteger)index;
@end
