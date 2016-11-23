//
//  ProductDetailFreeApplyBabyNameCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyBabyNameCell.h"

@interface ProductDetailFreeApplyBabyNameCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ProductDetailFreeApplyBabyNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.tf.text = showModel.babyName;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.showModel.babyName = textField.text;
}

@end
