//
//  ProductDetailToolBarButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailToolBarButton.h"

static CGFloat const kTitle_h = 17;
static CGFloat const kTitle_b = 2;
static CGFloat const kImage_s = 30;

@implementation ProductDetailToolBarButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat title_y = CGRectGetHeight(contentRect) - kTitle_h - kTitle_b;
    return CGRectMake(0, title_y, CGRectGetWidth(contentRect), kTitle_h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat image_x = (CGRectGetWidth(contentRect) - kImage_s) * 0.5;
    CGFloat image_y = (CGRectGetHeight(contentRect) - kTitle_h - kTitle_b - kImage_s) * 0.5;
    return CGRectMake(image_x, image_y, kImage_s, kImage_s);
}

@end
