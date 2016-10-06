//
//  AddressPickerRecordButton.m
//  KidsTC
//
//  Created by zhanping on 8/5/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddressPickerRecordButton.h"

@interface AddressPickerRecordButton ()
@property (nonatomic, weak) UIView *tipView;
@end

@implementation AddressPickerRecordButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:COLOR_PINK forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIView *tipView = [[UIView alloc]init];
        tipView.backgroundColor = COLOR_PINK;
        [self addSubview:tipView];
        tipView.hidden = !self.selected;
        self.tipView = tipView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tipView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-2, CGRectGetWidth(self.bounds), 2);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.tipView.hidden = !selected;
}

@end
