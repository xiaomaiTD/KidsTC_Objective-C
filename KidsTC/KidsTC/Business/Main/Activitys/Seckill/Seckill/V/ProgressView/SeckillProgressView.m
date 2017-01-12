//
//  SeckillProgressView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillProgressView.h"

@interface SeckillProgressView ()
@property (weak, nonatomic) IBOutlet UIView *valueView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueWidth;

@end

@implementation SeckillProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    CGFloat cornerRadius = CGRectGetHeight(self.bounds)*0.5;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorFromHexString:@"FC353A"].CGColor;
    
    self.valueView.layer.cornerRadius = cornerRadius;
    self.valueView.layer.masksToBounds = YES;
}

- (void)setProgress:(CGFloat)progress {
    if (progress>1) progress = 1;
    if (progress<0) progress = 0;
    _progress = progress;
    self.valueLabel.text = [NSString stringWithFormat:@"%zd%@",(int)(progress*100),@"%"];
    self.valueWidth.constant = CGRectGetWidth(self.bounds)*progress;
    [self layoutIfNeeded];
}

@end
