//
//  ArticleHomeClassButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleHomeClassButton.h"
#import "UIButton+WebCache.h"

static CGFloat const kTitleH = 15;
static CGFloat const kMarginV = 8;

@implementation ArticleHomeClassButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, CGRectGetHeight(contentRect) - kMarginV - kTitleH, CGRectGetWidth(contentRect), kTitleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat size = CGRectGetHeight(contentRect) - kMarginV * 3 - kTitleH;
    CGFloat x = (CGRectGetWidth(contentRect) - size) * 0.5;
    CGFloat y = kMarginV;
    return CGRectMake(x, y, size, size);
}

- (void)setItem:(ArticleHomeClassItem *)item{
    _item = item;
    [self setTitle:item.className forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:item.icon] forState:UIControlStateNormal placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    [self sd_setImageWithURL:[NSURL URLWithString:item.selectedIcon] forState:UIControlStateSelected placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}

@end
