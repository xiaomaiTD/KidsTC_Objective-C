//
//  ArticleHomeClassCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface ArticleHomeClassCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ArticleHomeClassCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    UIView *selectedBG = [[UIView alloc]init];
//    selectedBG.backgroundColor = COLOR_YELL;
//    self.selectedBackgroundView = selectedBG;
}

- (void)setItem:(ArticleHomeClassItem *)item {
    _item = item;
    _titleLabel.text = item.className;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
}


@end
