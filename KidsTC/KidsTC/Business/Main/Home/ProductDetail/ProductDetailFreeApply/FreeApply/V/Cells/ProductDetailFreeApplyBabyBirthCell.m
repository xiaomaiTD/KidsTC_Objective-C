//
//  ProductDetailFreeApplyBabyBirthCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyBabyBirthCell.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"

@interface ProductDetailFreeApplyBabyBirthCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ProductDetailFreeApplyBabyBirthCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    self.tf.text = [NSString zp_stringWithDate:showModel.babyBirth Format:DF_yMd_Text];;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeSelectBirth value:nil];
    }
    return NO;
}

@end
