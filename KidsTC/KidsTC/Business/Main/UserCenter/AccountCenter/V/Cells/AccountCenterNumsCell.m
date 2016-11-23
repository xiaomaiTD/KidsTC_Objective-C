//
//  AccountCenterNumsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterNumsCell.h"
#import "Colours.h"

@interface AccountCenterNumsCell ()
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *radishBtn;
@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
@property (weak, nonatomic) IBOutlet UIButton *eCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *balanceBtn;

@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet UILabel *radishL;
@property (weak, nonatomic) IBOutlet UILabel *couponL;
@property (weak, nonatomic) IBOutlet UILabel *eCardL;
@property (weak, nonatomic) IBOutlet UILabel *balanceL;
@end

@implementation AccountCenterNumsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.scoreBtn.tag = AccountCenterCellActionTypeScore;
    self.radishBtn.tag = AccountCenterCellActionTypeRadish;
    self.couponBtn.tag = AccountCenterCellActionTypeCoupon;
    self.eCardBtn.tag = AccountCenterCellActionTypeECard;
    self.balanceBtn.tag = AccountCenterCellActionTypeBalance;
    
    [self setBtnColor:self.scoreBtn];
    [self setBtnColor:self.radishBtn];
    [self setBtnColor:self.couponBtn];
    [self setBtnColor:self.eCardBtn];
    [self setBtnColor:self.balanceBtn];
    
    [self setLabelColor:self.scoreL];
    [self setLabelColor:self.radishL];
    [self setLabelColor:self.couponL];
    [self setLabelColor:self.eCardL];
    [self setLabelColor:self.balanceL];
}

- (void)setBtnColor:(UIButton *)btn {
    [btn setTitleColor:[UIColor colorFromHexString:@"444444"] forState:UIControlStateNormal];
}

- (void)setLabelColor:(UILabel *)label {
    label.textColor = [UIColor colorFromHexString:@"222222"];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    
    AccountCenterUserCount *userCount = model.data.userCount;
    
    self.scoreL.text = [NSString stringWithFormat:@"%zd",userCount.score_num];
    self.radishL.text = [NSString stringWithFormat:@"%zd",userCount.userRadishNum];
    self.couponL.text = [NSString stringWithFormat:@"%zd",userCount.coupon_num];
    
}

@end
