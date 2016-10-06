//
//  ZpMenuItemCell.m
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ZPPopoverCell.h"

@implementation ZPPopoverCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(ZPPopoverItem *)item{
    _item = item;
    self.itemImageView.image = [UIImage imageNamed:_item.imageName];
    self.itemTitleLabel.text = _item.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
