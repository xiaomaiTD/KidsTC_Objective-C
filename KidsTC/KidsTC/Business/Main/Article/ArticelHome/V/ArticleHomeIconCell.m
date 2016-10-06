//
//  ArticleHomeIconCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeIconCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"

@interface ArticleHomeIconCell ()
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *brefContentLabel;
@property (weak, nonatomic) IBOutlet UIView *infoContentView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation ArticleHomeIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.coulmnLabel.textColor = COLOR_PINK;
//    CALayer *iconImageViewLayer = self.iconImageView.layer;
//    iconImageViewLayer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    iconImageViewLayer.borderWidth = LINE_H;
    
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.coulmnLabel.text = item.columnTitle;
    self.titleLabel.attributedText = item.titleAttributeStr;
    self.brefContentLabel.attributedText = item.brifContentAttributeStr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.bottomView.item = item;
}

@end
