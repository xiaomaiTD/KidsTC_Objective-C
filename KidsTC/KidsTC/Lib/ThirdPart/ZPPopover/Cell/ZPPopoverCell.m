//
//  ZpMenuItemCell.m
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ZPPopoverCell.h"

@interface ZPPopoverCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ZPPopoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(ZPPopoverItem *)item{
    _item = item;
    self.itemImageView.image = [UIImage imageNamed:_item.imageName];
    self.itemTitleLabel.text = _item.title;
}

@end
