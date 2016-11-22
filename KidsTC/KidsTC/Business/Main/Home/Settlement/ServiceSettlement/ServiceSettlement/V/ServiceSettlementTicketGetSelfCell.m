//
//  ServiceSettlementTicketGetSelfCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementTicketGetSelfCell.h"

@interface ServiceSettlementTicketGetSelfCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameTipL;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UILabel *phoneTipL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@end

@implementation ServiceSettlementTicketGetSelfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *color = [UIColor colorFromHexString:@"555555"];
    self.nameTipL.textColor = color;
    self.nameTf.textColor = color;
    self.phoneTipL.textColor = color;
    self.phoneTf.textColor = color;
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
