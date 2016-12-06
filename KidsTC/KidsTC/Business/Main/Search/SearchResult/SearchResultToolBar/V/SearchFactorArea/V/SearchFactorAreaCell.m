//
//  SearchFactorAreaCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaCell.h"
#import "UIButton+Category.h"
#import "Colours.h"

@interface SearchFactorAreaCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation SearchFactorAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    [self.btn setBackgroundColor:[UIColor colorFromHexString:@"F2F2F2"] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
}

- (void)setItem:(SearchFactorAreaDataItem *)item {
    _item = item;
    self.btn.selected = _item.selected;
    [self.btn setTitle:_item.title forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}


@end
