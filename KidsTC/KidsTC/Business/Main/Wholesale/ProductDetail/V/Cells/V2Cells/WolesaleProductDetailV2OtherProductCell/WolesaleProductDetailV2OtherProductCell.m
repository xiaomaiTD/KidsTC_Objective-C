//
//  WolesaleProductDetailV2OtherProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2OtherProductCell.h"

@interface WolesaleProductDetailV2OtherProductCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation WolesaleProductDetailV2OtherProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.layer.cornerRadius = 2;
    self.tipL.layer.masksToBounds = YES;
    self.HLineH.constant = LINE_H;
}

- (void)setOtherProduct:(WholesaleProductDetailOtherProduct *)otherProduct {
    _otherProduct = otherProduct;
    self.nameL.text = otherProduct.productName;
    self.priceL.text = otherProduct.platformPrice;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeOtherProduct value:_otherProduct];
    }
}

@end
