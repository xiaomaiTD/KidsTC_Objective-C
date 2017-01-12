//
//  RadishMallItemsCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallItemsCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface RadishMallItemsCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation RadishMallItemsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setIcon:(RadishMallIcon *)icon {
    _icon = icon;
    [self.img sd_setImageWithURL:[NSURL URLWithString:icon.url] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.titleL.text = icon.name;
}

@end
