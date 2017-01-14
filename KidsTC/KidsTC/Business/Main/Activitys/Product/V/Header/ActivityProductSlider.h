//
//  ActivityProductSlider.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityProductContent.h"

extern CGFloat const kActivityProductSliderH;

@class ActivityProductSlider;
@protocol ActivityProductSliderDelegate <NSObject>
- (void)activityProductSlider:(ActivityProductSlider *)slider didSelectItem:(ActivityProductTabItem *)item index:(NSInteger)index;
@end

@interface ActivityProductSlider : UIView
@property (nonatomic, strong) ActivityProductContent *content;
@property (nonatomic, weak) id<ActivityProductSliderDelegate> delegate;
- (void)selectIndex:(NSUInteger)index toSelect:(BOOL)toSelect;
@end
