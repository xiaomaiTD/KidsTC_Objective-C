//
//  ActivityProductSliderItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductTabItem.h"

@class ActivityProductSliderItem;
@protocol ActivityProductSliderItemDelegate <NSObject>
- (void)didClickActivityProductSliderItem:(ActivityProductSliderItem *)item;
@end

@interface ActivityProductSliderItem : UIView
@property (nonatomic, strong) ActivityProductTabItem *item;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, weak) id<ActivityProductSliderItemDelegate> delegate;
@property (nonatomic, strong) UIColor *tabBgc;//普通背景颜色
@property (nonatomic, strong) UIColor *tabSelBgc;//选中背景颜色
@property (nonatomic, strong) UIColor *tabFontCor;//普通字体颜色
@property (nonatomic, strong) UIColor *tabSelFontCor;//选中字体颜色
@property (nonatomic, strong) UIColor *tabSelIndexCor;//下划线颜色
@property (nonatomic, assign) BOOL selected;
@end
