//
//  SeckillSliderTimeItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillSliderTimeItem.h"

@interface SeckillSliderTimeItem ()
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@property (weak, nonatomic) IBOutlet UIImageView *arrow_d_img;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation SeckillSliderTimeItem

- (void)setTime:(SeckillTimeTime *)time {
    _time = time;
    self.timeL.text = time.title;
    self.tipL.text = time.subTitle;
    self.selected = time.isChecked;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.time.isChecked = selected;
    [self setupStates];
}

- (void)setupStates {
    if (self.selected) {
        self.selImg.hidden = NO;
        self.arrow_d_img.hidden = NO;
        self.timeL.textColor = [UIColor colorFromHexString:@"ffffff"];
        self.tipL.textColor = [UIColor colorFromHexString:@"ffffff"];
    }else{
        self.selImg.hidden = YES;
        self.arrow_d_img.hidden = YES;
        self.timeL.textColor = [UIColor colorFromHexString:@"acadae"];
        self.tipL.textColor = [UIColor colorFromHexString:@"acadae"];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(didClickSeckillSliderTimeItem:)]) {
        [self.delegate didClickSeckillSliderTimeItem:self];
    }
}

@end
