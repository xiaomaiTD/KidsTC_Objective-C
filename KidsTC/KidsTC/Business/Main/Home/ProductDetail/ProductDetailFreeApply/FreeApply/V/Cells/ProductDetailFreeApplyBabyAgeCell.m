//
//  ProductDetailFreeApplyBabyAgeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyBabyAgeCell.h"

@interface ProductDetailFreeApplyBabyAgeCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;
@end

@implementation ProductDetailFreeApplyBabyAgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.tf.text = [NSString stringWithFormat:@"%zd",showModel.babyAge];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeSelectAge value:nil];
    }
    return NO;
}

@end
