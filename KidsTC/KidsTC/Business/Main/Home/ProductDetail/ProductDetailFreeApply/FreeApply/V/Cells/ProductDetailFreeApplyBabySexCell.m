//
//  ProductDetailFreeApplyBabySexCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyBabySexCell.h"

@interface ProductDetailFreeApplyBabySexCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ProductDetailFreeApplyBabySexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    NSArray *allKeys = showModel.babySex.allKeys;
    NSString *sexStr = @"";
    if (allKeys.count>0) {
        sexStr = allKeys.firstObject;
    }
    self.tf.text = sexStr;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
        [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeSelectSex value:nil];
    }
    return NO;
}


@end
