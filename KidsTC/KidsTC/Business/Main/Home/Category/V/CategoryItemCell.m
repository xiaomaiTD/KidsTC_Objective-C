//
//  CategoryItemCell.m
//  KidsTC
//
//  Created by zhanping on 3/17/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "CategoryItemCell.h"
#import "GHeader.h"
#import "UIImage+Category.h"

@implementation CategoryItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(CategoryListItem *)item{
    _item = item;
    self.titleLabel.text = item.Name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.CategoryImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}




@end
