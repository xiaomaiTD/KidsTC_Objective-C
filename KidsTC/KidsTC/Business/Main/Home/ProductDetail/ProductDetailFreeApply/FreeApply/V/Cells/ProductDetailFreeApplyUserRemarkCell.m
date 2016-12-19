//
//  ProductDetailFreeApplyUserRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyUserRemarkCell.h"
#import "NSString+Category.h"
#import "ServiceSettlementBuyNumTfInputView.h"

@interface ProductDetailFreeApplyUserRemarkCell ()<UITextViewDelegate,ServiceSettlementBuyNumTfInputViewDelegate>

@end

@implementation ProductDetailFreeApplyUserRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ServiceSettlementBuyNumTfInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView.delegate = self;
    inputView.tipL.text = @"请输入备注信息";
    inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tv.inputAccessoryView = inputView;
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    NSString *text = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KProductDetailFreeApplyUserRemark]];
    if (![text isNotNull]) {
        text = @"";
    }
    self.tv.text = text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [USERDEFAULTS setObject:textView.text forKey:KProductDetailFreeApplyUserRemark];
    [USERDEFAULTS synchronize];
}

#pragma mark - ServiceSettlementBuyNumTfInputViewDelegate

- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view actionType:(ServiceSettlementBuyNumTfInputViewActionType)type value:(id)value {
    [self.tv resignFirstResponder];
}

- (void)dealloc {
    [USERDEFAULTS setObject:@"" forKey:KProductDetailFreeApplyUserRemark];
    [USERDEFAULTS synchronize];
}

@end
