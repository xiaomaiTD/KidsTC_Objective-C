//
//  ScoreConsumeLargeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeLargeCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface ScoreConsumeLargeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;
@property (weak, nonatomic) IBOutlet UIView *priceBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceBGViewLeading;

@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIView *discountBGView;
@property (weak, nonatomic) IBOutlet UILabel *discountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountBGViewLeading;
@property (weak, nonatomic) IBOutlet UIView *ageBGView;
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageBGViewLeading;

@property (weak, nonatomic) IBOutlet UILabel *fightGroupL;
@property (weak, nonatomic) IBOutlet UIView *radishBGView;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;

@property (weak, nonatomic) IBOutlet UIView *btnBGView;
@property (weak, nonatomic) IBOutlet UILabel *btnL;

@property (nonatomic,strong) ScoreProductItem *product;
@end

@implementation ScoreConsumeLargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.discountBGView.layer.cornerRadius = 2;
    self.discountBGView.layer.masksToBounds = YES;
    self.ageBGView.layer.cornerRadius = 2;
    self.ageBGView.layer.masksToBounds = YES;
    self.btnBGView.layer.cornerRadius = 2;
    self.btnBGView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setItem:(ScoreConsumeShowItem *)item {
    [super setItem:item];
    ScoreProductItem *product = item.item;
    self.product = product;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG];
    _iconH.constant = (SCREEN_WIDTH-2*10)*product.picRate;
    
    switch (product.productRedirectType) {
        case ProductDetailTypeWholesale:
        {
            self.radishBGView.hidden = YES;
            self.radishCountL.text = nil;
            self.fightGroupL.hidden = NO;
            self.fightGroupL.text = product.joinDesc;
            self.priceBGViewLeading.constant = 15 + 8 + [product.joinDesc sizeWithAttributes:@{NSFontAttributeName:self.fightGroupL.font}].width;
            self.priceL.text = product.price;
        }
            break;
        case ProductDetailTypeRadish:
        {
            self.radishBGView.hidden = NO;
            self.radishCountL.text = [NSString stringWithFormat:@"%@根",product.radishCount];
            self.fightGroupL.hidden = YES;
            self.fightGroupL.text = nil;
            self.priceBGViewLeading.constant = 15 + 8 + [self.radishCountL.text sizeWithAttributes:@{NSFontAttributeName:self.radishCountL.font}].width + 37;
            self.priceL.text = [product.price isNotNull]?[NSString stringWithFormat:@"+%@元",product.price]:nil;
        }
            break;
        default:
        {
            self.radishBGView.hidden = YES;
            self.radishCountL.text = nil;
            self.fightGroupL.hidden = YES;
            self.fightGroupL.text = nil;
            self.priceBGViewLeading.constant = 15;
            self.priceL.text = product.price;
        }
            break;
    }
    
    self.nameL.text = product.productName;
    self.subTitleL.text = product.promotionText;
    
    if ([product.discount isNotNull]) {
        self.discountBGView.hidden = NO;
        self.discountBGViewLeading.constant = 8;
        self.discountL.text = product.discount;
    }else{
        self.discountBGView.hidden = YES;
        self.discountBGViewLeading.constant = 0;
        self.discountL.text = nil;
    }
    if ([product.ageGroup isNotNull]) {
        self.ageBGView.hidden = NO;
        self.ageBGViewLeading.constant = 8;
        self.ageL.text = product.ageGroup;
    }else{
        self.ageBGView.hidden = YES;
        self.ageBGViewLeading.constant = 0;
        self.ageL.text = nil;
    }
    self.btnL.text = product.btnName;
    [self layoutIfNeeded];
}

- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(scoreConsumeBaseCell:actionType:value:)]) {
        [self.delegate scoreConsumeBaseCell:self actionType:ScoreConsumeBaseCellActionTypeSegue value:self.product.segueModel];
    }
}
@end
