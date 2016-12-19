//
//  ServiceSettlementTicketGetSelfCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementTicketGetSelfCell.h"
#import "ServiceSettlementBuyNumTfInputView.h"

@interface ServiceSettlementTicketGetSelfCell ()<UITextFieldDelegate,ServiceSettlementBuyNumTfInputViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameTipL;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UILabel *phoneTipL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;

@end

@implementation ServiceSettlementTicketGetSelfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *color = [UIColor colorFromHexString:@"555555"];
    self.nameTipL.textColor = color;
    self.nameTf.textColor = color;
    self.phoneTipL.textColor = color;
    self.phoneTf.textColor = color;
    
    self.HLineOneH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    
    ServiceSettlementBuyNumTfInputView *inputView_name = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView_name.delegate = self;
    inputView_name.tipL.text = @"请输入姓名";
    inputView_name.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.nameTf.inputAccessoryView = inputView_name;
    
    ServiceSettlementBuyNumTfInputView *inputView_phone = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView_phone.delegate = self;
    inputView_phone.tipL.text = @"请输入电话";
    inputView_phone.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.phoneTf.inputAccessoryView = inputView_phone;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    self.item.ticketUserName = self.nameTf.text;
    self.item.ticketUserMobile = self.phoneTf.text;
}

#pragma mark - ServiceSettlementBuyNumTfInputViewDelegate

- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view actionType:(ServiceSettlementBuyNumTfInputViewActionType)type value:(id)value {
    [self.nameTf resignFirstResponder];
    [self.phoneTf resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nameTf) {
        self.item.ticketUserName = textField.text;
    }else{
        self.item.ticketUserMobile = textField.text;
    }
}

@end
