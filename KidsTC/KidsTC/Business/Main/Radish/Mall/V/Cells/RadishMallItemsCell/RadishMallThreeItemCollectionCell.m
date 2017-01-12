//
//  RadishMallThreeItemCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallThreeItemCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface RadishMallThreeItemCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation RadishMallThreeItemCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.layer.borderWidth = 1;
}

- (void)setIcon:(RadishMallIcon *)icon {
    _icon = icon;
    [self.img sd_setImageWithURL:[NSURL URLWithString:icon.url] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.titleL.text = icon.name;
}

@end
