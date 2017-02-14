//
//  ScoreConsumeSmallCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeSmallCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ScoreConsumeSmallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *btnBGView;
@property (weak, nonatomic) IBOutlet UILabel *btnL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet UILabel *fightGroupL;
@property (weak, nonatomic) IBOutlet UIView *radishBGView;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceBGViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (nonatomic,strong) ScoreProductItem *product;
@end

@implementation ScoreConsumeSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineH.constant = LINE_H;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    
    self.btnBGView.layer.cornerRadius = 4;
    self.btnBGView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tapGR];
    
}

- (void)setItem:(ScoreConsumeShowItem *)item {
    [super setItem:item];
    ScoreProductItem *product = item.item;
    self.product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = product.productName;
    self.btnL.text = product.btnName;
    self.priceL.text = product.price;
    self.originalPriceL.text = product.storePrice;
    
    switch (product.productRedirectType) {
        case ProductDetailTypeWholesale:
        {
            self.radishBGView.hidden = YES;
            self.radishCountL.text = nil;
            self.fightGroupL.hidden = NO;
            self.fightGroupL.text = product.joinDesc;
            self.priceBGViewLeading.constant = 15 + 8 + [product.joinDesc sizeWithAttributes:@{NSFontAttributeName:self.fightGroupL.font}].width;
        }
            break;
        case ProductDetailTypeRadish:
        {
            self.radishBGView.hidden = NO;
            self.radishCountL.text = [NSString stringWithFormat:@"%@根",product.radishCount];
            self.fightGroupL.hidden = YES;
            self.fightGroupL.text = nil;
            self.priceBGViewLeading.constant = 15 + 8 + [self.radishCountL.text sizeWithAttributes:@{NSFontAttributeName:self.radishCountL.font}].width + 37;
        }
            break;
        default:
        {
            self.radishBGView.hidden = YES;
            self.radishCountL.text = nil;
            self.fightGroupL.hidden = YES;
            self.fightGroupL.text = nil;
            self.priceBGViewLeading.constant = 15;
        }
            break;
    }
}

- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(scoreConsumeBaseCell:actionType:value:)]) {
        [self.delegate scoreConsumeBaseCell:self actionType:ScoreConsumeBaseCellActionTypeSegue value:self.product.segueModel];
    }
}

@end
