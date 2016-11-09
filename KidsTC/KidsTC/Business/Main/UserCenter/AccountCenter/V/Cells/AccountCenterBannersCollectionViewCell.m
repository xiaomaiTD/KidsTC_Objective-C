//
//  AccountCenterBannersCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBannersCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
@interface AccountCenterBannersCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AccountCenterBannersCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderWidth = LINE_H;
    self.imageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setBanner:(AccountCenterBanner *)banner {
    _banner = banner;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:banner.ImageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
