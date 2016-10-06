//
//  StrategyDetailAnnotationTipView.m
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StrategyDetailAnnotationTipView.h"

@interface StrategyDetailAnnotationTipView ()
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;

@end

@implementation StrategyDetailAnnotationTipView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.gotoBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(strategyDetailAnnotationTipViewDidClickOnGotoBtn:)]) {
        [self.delegate strategyDetailAnnotationTipViewDidClickOnGotoBtn:self];
    }
}


@end
