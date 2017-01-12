//
//  SeckillSliderTimeItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillTimeTime.h"

@class SeckillSliderTimeItem;
@protocol SeckillSliderTimeItemDelegate <NSObject>
- (void)didClickSeckillSliderTimeItem:(SeckillSliderTimeItem *)item;
@end

@interface SeckillSliderTimeItem : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) SeckillTimeTime *time;
@property (nonatomic, weak) id<SeckillSliderTimeItemDelegate> delegate;
@end
