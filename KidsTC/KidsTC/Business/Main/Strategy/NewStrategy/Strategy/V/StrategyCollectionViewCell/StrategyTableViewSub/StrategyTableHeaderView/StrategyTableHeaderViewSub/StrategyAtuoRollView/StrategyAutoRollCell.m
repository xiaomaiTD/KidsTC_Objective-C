//
//  AutoRollCell.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "StrategyAutoRollCell.h"
#import "UIImageView+WebCache.h"
@implementation StrategyAutoRollCell

- (void)setItem:(StrategyTypeListBannerItem *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:nil];
}
@end
