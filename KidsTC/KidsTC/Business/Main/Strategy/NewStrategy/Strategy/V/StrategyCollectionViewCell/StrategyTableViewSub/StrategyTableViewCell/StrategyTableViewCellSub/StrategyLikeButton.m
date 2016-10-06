//
//  StrategyLikeButton.m
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyLikeButton.h"
#define imageSize 18
#define BtnMargin 14
@implementation StrategyLikeButton

- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)setHighlighted:(BOOL)highlighted{}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = imageSize+BtnMargin;
    
    return CGRectMake(x, 0, contentRect.size.width-x, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat h = contentRect.size.height;
    CGFloat y = (h-imageSize)*0.5;
    return CGRectMake(BtnMargin, y, imageSize, imageSize);
}



@end
