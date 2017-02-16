//
//  RadishSettlementUserRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishSettlementUserRemarkCell.h"
#import "NSString+Category.h"
#import "RadishSettlementBuyNumTfInputView.h"
#import "iToast.h"
#import "Colours.h"

@interface RadishSettlementUserRemarkCell ()<UITextViewDelegate,RadishSettlementBuyNumTfInputViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation RadishSettlementUserRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    RadishSettlementBuyNumTfInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"RadishSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView.delegate = self;
    inputView.tipL.text = @"请输入备注信息";
    inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tv.inputAccessoryView = inputView;
}

- (void)setData:(RadishSettlementData *)data {
    [super setData:data];
    NSString *text = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KRadishSettlementUserRemark]];
    if (![text isNotNull]) {
        text = @"";
    }
    self.tv.text = text;
    self.tipL.hidden = self.tv.text.length>0;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.tipL.hidden = textView.text.length>0;
    if (textView.text.length>100) {
        textView.text = [textView.text substringToIndex:100];
        [[iToast makeText:@"最多只能输入100个字哦"] show];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [USERDEFAULTS setObject:textView.text forKey:KRadishSettlementUserRemark];
    [USERDEFAULTS synchronize];
}

#pragma mark - RadishSettlementBuyNumTfInputViewDelegate

- (void)radishSettlementBuyNumTfInputView:(RadishSettlementBuyNumTfInputView *)view actionType:(RadishSettlementBuyNumTfInputViewActionType)type value:(id)value {
    [self.tv resignFirstResponder];
}

- (void)dealloc {
    [USERDEFAULTS setObject:@"" forKey:KRadishSettlementUserRemark];
    [USERDEFAULTS synchronize];
}

@end
