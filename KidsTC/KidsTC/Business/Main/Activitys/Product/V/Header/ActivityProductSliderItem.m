//
//  ActivityProductSliderItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductSliderItem.h"

@interface ActivityProductSliderItem ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ActivityProductSliderItem

- (void)setItem:(ActivityProductTabItem *)item {
    _item = item;
    self.titleL.text = item.tabName;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickActivityProductSliderItem:)]) {
        [self.delegate didClickActivityProductSliderItem:self];
    }
}

@end
