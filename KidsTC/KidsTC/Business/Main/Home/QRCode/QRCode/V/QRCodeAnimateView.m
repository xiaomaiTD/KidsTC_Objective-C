//
//  QRCodeAnimateView.m
//  005-QRCodeDeom
//
//  Created by 詹平 on 2016/10/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "QRCodeAnimateView.h"

@interface QRCodeAnimateView ()
@property (nonatomic, strong) UIImageView *animateImageView;
@property (nonatomic, strong) UIImageView *topBGImageView;
@property (nonatomic, strong) UIImageView *centerBGImageView;
@property (nonatomic, strong) UIImageView *bottomBGImageView;
@end

@implementation QRCodeAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *animateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbarcode_scan_line"]];
        [self addSubview:animateImageView];
        self.animateImageView = animateImageView;
        
        UIImageView *topBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbarcode_scan_box_top"]];
        [self addSubview:topBGImageView];
        self.topBGImageView = topBGImageView;
        
        UIImageView *centerBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbarcode_scan_box_mid"]];
        [self addSubview:centerBGImageView];
        self.centerBGImageView = centerBGImageView;
        
        UIImageView *bottomBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbarcode_scan_box_bottom"]];
        [self addSubview:bottomBGImageView];
        self.bottomBGImageView = bottomBGImageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.bounds);
    CGFloat self_h = CGRectGetHeight(self.bounds);
    
    self.animateImageView.frame = CGRectMake(0, 0, self_w, 0.1 * self_w);
    
    CGFloat margin = 4;
    CGFloat top_bottom_h = 14;
    
    CGFloat topBGImageView_x = -margin;
    CGFloat topBGImageView_y = -margin;
    CGFloat topBGImageView_w = self_w + 2 * margin;
    CGFloat topBGImageView_h = top_bottom_h;
    CGRect topBGImageView_f = CGRectMake(topBGImageView_x, topBGImageView_y, topBGImageView_w, topBGImageView_h);
    self.topBGImageView.frame = topBGImageView_f;
    
    CGFloat centerBGImageView_x = -margin;
    CGFloat centerBGImageView_y = CGRectGetMaxY(topBGImageView_f);
    CGFloat centerBGImageView_w = self_w + 2 * margin;
    CGFloat centerBGImageView_h = self_h - 2 * (top_bottom_h - margin);
    CGRect centerBGImageView_f = CGRectMake(centerBGImageView_x, centerBGImageView_y, centerBGImageView_w, centerBGImageView_h);
    self.centerBGImageView.frame = centerBGImageView_f;
    
    CGFloat bottomBGImageView_x = -margin;
    CGFloat bottomBGImageView_y = CGRectGetMaxY(centerBGImageView_f);
    CGFloat bottomBGImageView_w = self_w + 2 * margin;
    CGFloat bottomBGImageView_h = top_bottom_h;
    CGRect bottomBGImageView_f = CGRectMake(bottomBGImageView_x, bottomBGImageView_y, bottomBGImageView_w, bottomBGImageView_h);
    self.bottomBGImageView.frame = bottomBGImageView_f;
    
    [self stopAnimate];
    [self startAnimate];
}

- (void)startAnimate {
    self.animateImageView.hidden = NO;
    CGFloat self_h = CGRectGetHeight(self.bounds);
    CGFloat animateView_h = CGRectGetHeight(self.animateImageView.bounds);
    [UIView animateWithDuration:2 animations:^{
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
        self.animateImageView.transform = CGAffineTransformTranslate(self.animateImageView.transform, 0, self_h - animateView_h);
    }];
}

- (void)stopAnimate {
    self.animateImageView.hidden = YES;
    [self.layer removeAllAnimations];
}

@end
