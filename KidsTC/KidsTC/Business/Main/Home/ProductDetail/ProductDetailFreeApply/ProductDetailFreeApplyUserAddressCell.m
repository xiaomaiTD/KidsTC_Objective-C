//
//  ProductDetailFreeApplyUserAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyUserAddressCell.h"

@interface ProductDetailFreeApplyUserAddressCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailFreeApplyUserAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.addressL.text = showModel.userAddress.addressDescription;
    self.nameL.text = showModel.userAddress.peopleName;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeUserAddress value:nil];
    }
}

@end
