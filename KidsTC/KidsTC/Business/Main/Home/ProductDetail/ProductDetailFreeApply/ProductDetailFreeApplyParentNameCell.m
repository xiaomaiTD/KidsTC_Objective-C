//
//  ProductDetailFreeApplyParentNameCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyParentNameCell.h"

@interface ProductDetailFreeApplyParentNameCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ProductDetailFreeApplyParentNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.tf.text = showModel.parentName;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.showModel.parentName = textField.text;
}

@end
