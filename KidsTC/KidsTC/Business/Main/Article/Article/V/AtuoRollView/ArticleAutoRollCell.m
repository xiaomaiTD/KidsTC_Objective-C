//
//  AutoRollCell.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "ArticleAutoRollCell.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@implementation ArticleAutoRollCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.iconImageView = imageView;
    }
    return self;
}


- (void)setIsBannerHaveInset:(BOOL)isBannerHaveInset{
    _isBannerHaveInset = isBannerHaveInset;
    if (isBannerHaveInset) {
        self.iconImageView.frame = CGRectMake(12, 12, CGRectGetWidth(self.frame)-24, CGRectGetHeight(self.frame)-24);
    }else{
        self.iconImageView.frame = self.bounds;
    }
}

- (void)setBannerItem:(AHBannersItem *)bannerItem{
    _bannerItem = bannerItem;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_bannerItem.imgUrl]];
}

@end
