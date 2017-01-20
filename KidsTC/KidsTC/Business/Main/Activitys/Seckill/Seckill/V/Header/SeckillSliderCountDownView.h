//
//  SeckillSliderCountDownView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillDataData.h"

@class SeckillSliderCountDownView;
@protocol SeckillSliderCountDownViewDelegate <NSObject>
- (void)seckillSliderCountDownViewCountDownOver:(SeckillSliderCountDownView *)view;
@end

@interface SeckillSliderCountDownView : UIView
@property (nonatomic, strong) SeckillDataData *data;
@property (nonatomic, weak) id<SeckillSliderCountDownViewDelegate> delegate;
@end
