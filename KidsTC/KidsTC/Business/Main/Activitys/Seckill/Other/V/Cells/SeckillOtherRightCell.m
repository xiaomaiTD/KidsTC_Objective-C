//
//  SeckillOtherRightCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherRightCell.h"
#import "UIImageView+WebCache.h"

@interface SeckillOtherRightCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@end

@implementation SeckillOtherRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
}

- (void)setItem:(SeckillOtherFloorItem *)item {
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.content.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.iconH.constant = CGRectGetWidth(self.icon.bounds) * item.ratio;
    [self layoutIfNeeded];
}

@end
