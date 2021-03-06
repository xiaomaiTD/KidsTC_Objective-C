//
//  TipButton.m
//  KidsTC
//
//  Created by zhanping on 7/28/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "TipButton.h"
#define TIPLABEL_MARGIN_INSET 2

@interface TipButton ()

@end

@implementation TipButton

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        UILabel *tipLabel = [[UILabel alloc]init];
        //tipLabel.backgroundColor = COLOR_PINK;
        tipLabel.font = [UIFont systemFontOfSize:11];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.hidden = YES;
        
        [self addSubview:tipLabel];
        _tipLabel = tipLabel;
    }
    return _tipLabel;
}

- (void)setBadgeValue:(NSUInteger)badgeValue{
    _badgeValue = badgeValue;
    self.tipLabel.hidden = badgeValue<=0;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.tipLabel.hidden) {
        switch (self.badgeType) {
            case TipButtonBadgeTypeNum:
            {
                [self makeNumBadge];
            }
                break;
            case TipButtonBadgeTypeIcon:
            {
                [self makeIconBadge];
            }
                break;
        }
    }
}

- (void)makeNumBadge{
    
    NSString *tipStr = (self.badgeValue>999)?@"999+":[NSString stringWithFormat:@"%zd",self.badgeValue];
    CGSize tipLabelStrSize = [tipStr sizeWithAttributes:@{NSFontAttributeName:self.tipLabel.font}];
    CGFloat tipLabelStrH = tipLabelStrSize.height;
    CGFloat tipLabelStrW = tipLabelStrSize.width;
    
    tipLabelStrW = tipLabelStrW>tipLabelStrH?(tipLabelStrW+2*TIPLABEL_MARGIN_INSET):tipLabelStrH;
    
    int tipLabelH = (int)(tipLabelStrH + 2*TIPLABEL_MARGIN_INSET);
    int tipLabelW = (int)(tipLabelStrW + 2*TIPLABEL_MARGIN_INSET);
    int tipLabelX = (int)(CGRectGetMaxX(self.imageView.frame)-tipLabelW*0.5);
    int tipLabelY = (int)(CGRectGetMinY(self.imageView.frame)-tipLabelH*0.5);
    self.tipLabel.frame = CGRectMake(tipLabelX, tipLabelY, tipLabelW, tipLabelH);
    self.tipLabel.text = tipStr;
    
    CALayer *layer = self.tipLabel.layer;
    layer.cornerRadius = tipLabelH*0.5;
    //layer.masksToBounds = YES;
    layer.backgroundColor = COLOR_PINK.CGColor;
    
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 1;
    /*
     layer.shadowColor = [UIColor blackColor].CGColor;
     layer.shadowOffset = CGSizeMake(2, 2);
     layer.shadowRadius = 2;
     layer.shadowOpacity = 0.5;
     */
}

- (void)makeIconBadge{
    
    CGFloat tipLabelSize = 7;
    CGFloat tipLabelX = CGRectGetMaxX(self.imageView.frame)-tipLabelSize*0.5;
    CGFloat tipLabelY = CGRectGetMinY(self.imageView.frame)-tipLabelSize*0.5;
    self.tipLabel.frame = CGRectMake(tipLabelX, tipLabelY, tipLabelSize, tipLabelSize);
    self.tipLabel.text = @"";
    
    CALayer *layer = self.tipLabel.layer;
    layer.cornerRadius = tipLabelSize*0.5;
    //layer.masksToBounds = YES;
    layer.backgroundColor = COLOR_PINK.CGColor;
}


@end
