//
//  ZpMenuView.h
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPPopoverItem.h"
@protocol ZPPopoverDelegate <NSObject>
- (void)didSelectMenuItemAtIndex:(NSUInteger)index;
@end

@interface ZPPopover : UIView
@property (nonatomic, weak) id<ZPPopoverDelegate> delegate;

/**
 *  生产ZpMenuView对象
 *
 *  @param topPoint 小三角的顶点坐标(在Window视图里面的坐标)
 *  @param items    用于显示的Item
 *
 *  @return ZpMenuView对象
 */
+(ZPPopover *)popoverWithTopPointInWindow:(CGPoint)topPoint items:(NSArray<ZPPopoverItem *> *)items;

//显示
- (void)show;
- (void)hide;
@end
