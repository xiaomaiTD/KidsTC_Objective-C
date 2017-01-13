//
//  SeckillSliderDateItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillSliderDateItem.h"

@interface SeckillSliderDateItem ()
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation SeckillSliderDateItem

- (void)setDate:(SeckillTimeDate *)date {
    _date = date;
    self.dateL.text = date.title;
    self.selected = date.isChecked;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.date.isChecked = selected;
    [self setupStates];
}

- (void)setupStates {
    if (self.selected) {
        self.dateL.textColor = [UIColor colorFromHexString:@"fb3438"];
    }else{
        self.dateL.textColor = [UIColor colorFromHexString:@"acadae"];
    }
}

- (IBAction)action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickSeckillSliderDateItem:)]) {
        [self.delegate didClickSeckillSliderDateItem:self];
    }
}

@end
