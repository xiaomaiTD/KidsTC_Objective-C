//
//  ArticleHomeBigImgCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBigImgCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"
#import "NSString+Category.h"

#define ICON_H_INSETS 12

@interface ArticleHomeBigImgCell ()
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UILabel *brefContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brefContentLabelConstraintTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewConstraintBottomMargin;
@end

@implementation ArticleHomeBigImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.coulmnLabel.textColor = COLOR_PINK;
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.iconImageViewConstraintHeight.constant = item.ratio*(SCREEN_WIDTH-2*ICON_H_INSETS);
    self.coulmnLabel.text = item.columnTitle;
    self.brefContentLabel.attributedText = item.brifContentAttributeStr;
    self.brefContentLabelConstraintTopMargin.constant = item.brifContentAttributeStr.length>0?8:0;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.titleLabel.text = item.title;
    self.bottomView.item = item;
    self.bottomView.hidden = ![item.authorName isNotNull];
    self.iconImageViewConstraintBottomMargin.constant = self.bottomView.hidden?12:44;
}

@end
