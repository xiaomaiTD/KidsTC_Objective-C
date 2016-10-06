//
//  SearchResultProductCell.m
//  KidsTC
//
//  Created by zhanping on 7/5/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultProductCell.h"
#import "FiveStarsView.h"
#import "GHeader.h"
@interface SearchResultProductCell ()

@property (weak, nonatomic) IBOutlet UIView *imageBGView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;
@property (weak, nonatomic) IBOutlet FiveStarsView *startsView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLabel;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullCutLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation SearchResultProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    self.selectedBackgroundView = selectedBackgroundView;
    self.imageBGView.layer.cornerRadius = 4;
    self.imageBGView.layer.masksToBounds = YES;
    self.imageBGView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageBGView.layer.borderWidth = LINE_H;
    self.saleCountLabel.textColor = COLOR_BLUE;
    self.priceLabel.textColor = COLOR_PINK;
    self.horizontalLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.priceLabel setNeedsUpdateConstraints];
    [self.priceLabel updateConstraintsIfNeeded];
    [self.priceLabel setNeedsLayout];
    [self.priceLabel layoutIfNeeded];
}

- (void)setItem:(SearchResultProductItem *)item{
    
    _item = item;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]
                             placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    [self setStatusImageViewStatus];
    self.couponImageView.hidden = !item.isHaveCoupon;
    self.startsView.starNumber = item.level;
    self.productNameLabel.text = item.serveName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
    self.saleCountLabel.text = [NSString stringWithFormat:@"%zd",item.sale];
    self.tipLabel.attributedText = item.tipStr;
    self.firstFullCutLabel.attributedText = item.firstFullCutStr;
    self.horizontalLine.hidden = !(item.firstFullCutStr.length>0);
}

- (void)setStatusImageViewStatus{
    
    switch (self.item.status) {
        case ProductStatusHasSoldOut:
        {
            self.statusImageView.image = [UIImage imageNamed:@"servicelist_soldout"];
            self.statusImageView.hidden = NO;
        }
            break;
        case ProductStatusNoStore:
        case ProductStatusNotBegin:
        case ProductStatusHasTakenOff:
        {
            self.statusImageView.image = [UIImage imageNamed:@"servicelist_notsaling"];
            self.statusImageView.hidden = NO;
        }
            break;
        default:
        {
            self.statusImageView.hidden = YES;
        }
            break;
    }
}

@end
