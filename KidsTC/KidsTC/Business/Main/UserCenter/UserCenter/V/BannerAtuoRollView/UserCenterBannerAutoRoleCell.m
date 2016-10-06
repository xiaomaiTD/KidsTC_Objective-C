//
//  BannerItemCell.m
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import "UserCenterBannerAutoRoleCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
@implementation UserCenterBannerAutoRoleCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconImageView.layer.borderWidth = LINE_H;
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setItem:(UserCenterBannersItem *)item{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.ImageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}


@end
