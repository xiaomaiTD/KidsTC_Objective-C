//
//  ServiceSettlementUserRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementUserRemarkCell.h"
#import "NSString+Category.h"
#import "ServiceSettlementBuyNumTfInputView.h"
#import "iToast.h"
#import "Colours.h"


@interface ServiceSettlementUserRemarkCell ()<UITextViewDelegate,ServiceSettlementBuyNumTfInputViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *inputBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputH;

@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UILabel *tvTipL;

@end

@implementation ServiceSettlementUserRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ServiceSettlementBuyNumTfInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView.delegate = self;
    inputView.tipL.text = @"请输入备注信息";
    inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tv.inputAccessoryView = inputView;
    self.tv.font = [UIFont systemFontOfSize:14];
    self.tv.textColor = [UIColor colorFromHexString:@"222222"];
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    NSString *text = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KServiceSettlementUserRemark]];
    if (![text isNotNull]) {
        text = @"";
    }
    self.tv.text = text;
    self.tvTipL.hidden = self.tv.text.length>0;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.tvTipL.hidden = textView.text.length>0;
    
    if (textView.text.length>100) {
        textView.text = [textView.text substringToIndex:100];
        [[iToast makeText:@"最多只能输入100个字哦"] show];
    }
//    
//    CGFloat height = [textView.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size.height + 8;
//    if (height<16) height=16;
//    self.inputH.constant =height;
//    
//    [self layoutIfNeeded];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [USERDEFAULTS setObject:textView.text forKey:KServiceSettlementUserRemark];
    [USERDEFAULTS synchronize];
}

#pragma mark - ServiceSettlementBuyNumTfInputViewDelegate

- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view actionType:(ServiceSettlementBuyNumTfInputViewActionType)type value:(id)value {
    [self.tv resignFirstResponder];
}

- (void)dealloc {
    [USERDEFAULTS setObject:@"" forKey:KServiceSettlementUserRemark];
    [USERDEFAULTS synchronize];
}

@end
