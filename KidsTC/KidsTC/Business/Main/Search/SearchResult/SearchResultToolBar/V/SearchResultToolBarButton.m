//
//  SearchResultToolBarButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultToolBarButton.h"

static CGFloat const img_s = 8;
static CGFloat const title_img_margin = 4;

@implementation SearchResultToolBarButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat title_w = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
    CGFloat totle_w = title_w + title_img_margin + img_s;
    CGFloat title_x = (CGRectGetWidth(contentRect) - totle_w) * 0.5;
    CGFloat img_x = title_x + title_w + title_img_margin;
    return CGRectMake(img_x, (CGRectGetHeight(contentRect) - img_s) * 0.5, img_s, img_s);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat title_w = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
    CGFloat totle_w = title_w + title_img_margin + img_s;
    CGFloat title_x = (CGRectGetWidth(contentRect) - totle_w) * 0.5;
    return CGRectMake(title_x, 0, title_w, CGRectGetHeight(contentRect));
}

@end
