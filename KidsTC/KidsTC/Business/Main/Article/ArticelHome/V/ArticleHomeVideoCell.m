//
//  ArticleHomeVideoCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeVideoCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"

#define ICON_H_INSETS 12

@interface ArticleHomeVideoCell ()
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UILabel *brefContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewConstraintHeight;
@end

@implementation ArticleHomeVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coulmnLabel.textColor = COLOR_PINK;
//    self.iconImageView.layer.borderWidth = LINE_H;
//    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.iconImageViewConstraintHeight.constant = item.ratio*(SCREEN_WIDTH-2*ICON_H_INSETS);
    self.coulmnLabel.text = item.columnTitle;
    self.brefContentLabel.attributedText = item.brifContentAttributeStr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.bottomView.item = item;
}

@end
