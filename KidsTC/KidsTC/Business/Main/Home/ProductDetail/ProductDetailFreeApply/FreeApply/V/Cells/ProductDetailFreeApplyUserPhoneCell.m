//
//  ProductDetailFreeApplyUserPhoneCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyUserPhoneCell.h"

@interface ProductDetailFreeApplyUserPhoneCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIImageView *penImageView;
@end

@implementation ProductDetailFreeApplyUserPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.tf.text = showModel.userPhone;
    self.penImageView.hidden = showModel.hidePen;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.showModel.hidePen = YES;
    self.penImageView.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.showModel.userPhone = textField.text;
}

@end
