//
//  SearchFactorAreaCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaCell.h"

@interface SearchFactorAreaCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;

@end

@implementation SearchFactorAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(SearchFactorAreaDataItem *)item {
    _item = item;
    self.titleL.text = _item.title;
    self.checkImg.hidden = !_item.selected;
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}


@end
