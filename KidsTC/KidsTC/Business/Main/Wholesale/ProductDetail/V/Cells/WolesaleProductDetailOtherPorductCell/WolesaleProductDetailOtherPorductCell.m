//
//  WolesaleProductDetailOtherPorductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailOtherPorductCell.h"
#import "UIImageView+WebCache.h"

@interface WolesaleProductDetailOtherPorductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceTipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *originPriceHLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WolesaleProductDetailOtherPorductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.originPriceHLineH.constant = LINE_H;
    self.HLineH.constant = LINE_H;
}

- (void)setOtherProduct:(WholesaleProductDetailOtherProduct *)otherProduct {
    _otherProduct = otherProduct;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:otherProduct.image] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = otherProduct.productName;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",otherProduct.price];
    self.originalPriceL.text = [NSString stringWithFormat:@"¥%@",otherProduct.platformPrice];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeOtherProduct value:_otherProduct];
    }
}

@end
