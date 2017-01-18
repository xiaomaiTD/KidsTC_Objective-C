//
//  WholesaleSettlementPhoneCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementPhoneCell.h"

@interface WholesaleSettlementPhoneCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *tipBGView;
@property (weak, nonatomic) IBOutlet UILabel *tipTitleL;
@property (weak, nonatomic) IBOutlet UILabel *tipSubL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTipH;

@property (weak, nonatomic) IBOutlet UIView *phoneBGView;
@property (weak, nonatomic) IBOutlet UILabel *phoneTipL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLinePhoneH;

@property (weak, nonatomic) IBOutlet UIView *securityCodeBGView;
@property (weak, nonatomic) IBOutlet UILabel *securityCodeTipL;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineSecurityCodeH;
@property (weak, nonatomic) IBOutlet UIButton *securityCodeBtn;

@end

@implementation WholesaleSettlementPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineTipH.constant = LINE_H;
    self.HLinePhoneH.constant = LINE_H;
    self.HLineSecurityCodeH.constant = LINE_H;
    self.securityCodeBtn.layer.cornerRadius = 4;
    self.securityCodeBtn.layer.masksToBounds = YES;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
}

@end
