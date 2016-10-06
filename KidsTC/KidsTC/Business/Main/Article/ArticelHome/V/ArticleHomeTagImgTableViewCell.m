//
//  ArticleHomeTagImgTableViewCell.m
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeTagImgTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface ArticleHomeTagImgTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation ArticleHomeTagImgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    CALayer  *iconImageViewLayer           = self.iconImageView.layer;
//    iconImageViewLayer.borderColor         = [UIColor groupTableViewBackgroundColor].CGColor;
//    iconImageViewLayer.borderWidth         = LINE_H;
    self.priceLabel.textColor              = COLOR_PINK;
    self.HLineConstraintHeight.constant    = LINE_H;
    UIView *selectedBackgroundView         = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    self.selectedBackgroundView            = selectedBackgroundView;
}

- (void)setProduct:(ArticleHomeProduct *)product {
    _product = product;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:product.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.productTitleLabel.text = product.title;
    NSString *priceTitle = [product.priceTitle isNotNull]?[NSString stringWithFormat:@"%@:",product.priceTitle]:@"";
    self.priceTitleLabel.text = priceTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.1f",product.price];
}

@end
