//
//  ProductDetailToolBarButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailToolBarButton.h"
#import "Colours.h"

static CGFloat const kTitle_h = 11;
static CGFloat const kTitle_b = 5;
static CGFloat const kImage_s = 20;

@implementation ProductDetailToolBarButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self setTitleColor:[UIColor colorFromHexString:@"666666"] forState:UIControlStateNormal];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat title_y = CGRectGetHeight(contentRect) - kTitle_h - kTitle_b;
    return CGRectMake(0, title_y, CGRectGetWidth(contentRect), kTitle_h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat image_x = (CGRectGetWidth(contentRect) - kImage_s) * 0.5;
    CGFloat image_y = (CGRectGetHeight(contentRect) - kTitle_h - kTitle_b - kImage_s) * 0.5 + 1;
    return CGRectMake(image_x, image_y, kImage_s, kImage_s);
}

@end
