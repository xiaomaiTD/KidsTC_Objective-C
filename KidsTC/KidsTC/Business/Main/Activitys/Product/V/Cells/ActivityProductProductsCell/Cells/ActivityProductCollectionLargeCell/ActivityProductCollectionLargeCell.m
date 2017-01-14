//
//  ActivityProductCollectionLargeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionLargeCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
@interface ActivityProductCollectionLargeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *ageTipView;
@property (weak, nonatomic) IBOutlet UILabel *ageTipL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIImageView *timeIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *flashTipL;
@property (weak, nonatomic) IBOutlet UILabel *wholesaleTipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceLeadingMargin;
@end

@implementation ActivityProductCollectionLargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
}
- (void)setItem:(ActivityProductItem *)item {
    [super setItem:item];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.nameL.text = item.productName;
    self.ageTipL.text = item.ageGroup;
    self.ageTipView.hidden = ![item.ageGroup isNotNull];
    self.tipL.text = item.promotionText;
    self.addressL.text = item.storeName;
    self.addressIcon.hidden = ![item.storeName isNotNull];
    self.timeL.text = item.useTimeStr;
    self.timeIcon.hidden = ![item.useTimeStr isNotNull];
    [self.buyBtn setTitle:item.btnName forState:UIControlStateNormal];
    self.priceL.text = item.priceDesc;
    self.wholesaleTipL.text = [NSString stringWithFormat:@"%@",item.joinDesc];
    self.iconH.constant = (SCREEN_WIDTH - 2*10) * item.ratio;
    switch (item.productRedirect) {
        case ProductDetailTypeFalsh:
        {
            self.flashTipL.hidden = NO;
            self.wholesaleTipL.hidden = YES;
            self.priceLeadingMargin.constant = 40;
        }
            break;
        case ProductDetailTypeWholesale:
        {
            self.flashTipL.hidden = YES;
            self.wholesaleTipL.hidden = NO;
            CGSize size = [self.wholesaleTipL.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            self.priceLeadingMargin.constant = size.width + 8;
        }
            break;
        default:
        {
            self.flashTipL.hidden = YES;
            self.wholesaleTipL.hidden = YES;
            self.priceLeadingMargin.constant = 0;
        }
            break;
    }
}
@end
