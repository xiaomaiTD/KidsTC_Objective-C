//
//  SeckillSlider.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillTimeData.h"
#import "SeckillDataData.h"
extern CGFloat const kSeckillSliderH;

@class SeckillSlider;
@protocol SeckillSliderDelegate <NSObject>
- (void)seckillSlider:(SeckillSlider *)slider didSelectTimeItem:(SeckillTimeTime *)time;
- (void)seckillSliderCountDownOver:(SeckillSlider *)slider;
@end

@interface SeckillSlider : UIView
@property (nonatomic, strong) SeckillTimeData *timeData;
@property (nonatomic, strong) SeckillDataData *dataData;
@property (nonatomic, weak) id<SeckillSliderDelegate> delegate;
@end
