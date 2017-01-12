//
//  SeckillSliderDateItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillTimeDate.h"

@class SeckillSliderDateItem;
@protocol SeckillSliderDateItemDelegate <NSObject>
- (void)didClickSeckillSliderDateItem:(SeckillSliderDateItem *)item;
@end

@interface SeckillSliderDateItem : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) SeckillTimeDate *date;
@property (nonatomic, weak) id<SeckillSliderDateItemDelegate> delegate;
@end
