//
//  AccountCenterItemsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterItemsCell.h"
#import "Colours.h"

@interface AccountCenterItemsCell ()
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *radishMallBtn;
@property (weak, nonatomic) IBOutlet UIButton *myFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *myAppoinmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareMakeMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *bringUpHeadlineBtn;
@property (weak, nonatomic) IBOutlet UIButton *customerServicesBtn;
@property (weak, nonatomic) IBOutlet UIButton *opinionBtn;

@property (weak, nonatomic) IBOutlet UILabel *historyL;
@property (weak, nonatomic) IBOutlet UILabel *radishMallL;
@property (weak, nonatomic) IBOutlet UILabel *myFlashL;
@property (weak, nonatomic) IBOutlet UILabel *myAppoinmentL;
@property (weak, nonatomic) IBOutlet UILabel *shareMakeMoneyL;
@property (weak, nonatomic) IBOutlet UILabel *bringUpHeadlineL;
@property (weak, nonatomic) IBOutlet UILabel *customerServicesL;
@property (weak, nonatomic) IBOutlet UILabel *opinionL;

@property (weak, nonatomic) IBOutlet UILabel *historySubL;
@property (weak, nonatomic) IBOutlet UILabel *radishMallSubL;
@property (weak, nonatomic) IBOutlet UILabel *myFlashSubL;
@property (weak, nonatomic) IBOutlet UILabel *myAppoinmentSubL;
@property (weak, nonatomic) IBOutlet UILabel *shareMakeMoneySubL;
@property (weak, nonatomic) IBOutlet UILabel *bringUpHeadlineSubL;
@property (weak, nonatomic) IBOutlet UILabel *customerServicesSubL;
@property (weak, nonatomic) IBOutlet UILabel *opinionSubL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineTwoH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineThreeH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineFourH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineThreeH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineFourH;

@property (weak, nonatomic) IBOutlet UILabel *radishTipL;
@property (weak, nonatomic) IBOutlet UILabel *flashTipL;
@property (weak, nonatomic) IBOutlet UILabel *appoinmentTipL;
@property (weak, nonatomic) IBOutlet UILabel *shareTipL;
@end

@implementation AccountCenterItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.historyBtn.tag = AccountCenterCellActionTypeHistory;
    self.radishMallBtn.tag = AccountCenterCellActionTypeRadishMall;
    self.myFlashBtn.tag = AccountCenterCellActionTypeMyFlash;
    self.myAppoinmentBtn.tag = AccountCenterCellActionTypeMyAppoinment;
    self.shareMakeMoneyBtn.tag = AccountCenterCellActionTypeShareMakeMoney;
    self.bringUpHeadlineBtn.tag = AccountCenterCellActionTypeBringUpHeadline;
    self.customerServicesBtn.tag = AccountCenterCellActionTypeCustomerServices;
    self.opinionBtn.tag = AccountCenterCellActionTypeOpinion;
    
    [self setTitleColor:self.historyL];
    [self setTitleColor:self.radishMallL];
    [self setTitleColor:self.myFlashL];
    [self setTitleColor:self.myAppoinmentL];
    [self setTitleColor:self.shareMakeMoneyL];
    [self setTitleColor:self.bringUpHeadlineL];
    [self setTitleColor:self.customerServicesL];
    [self setTitleColor:self.opinionL];
    
    [self setSubTitleColor:self.historySubL];
    [self setSubTitleColor:self.radishMallSubL];
    [self setSubTitleColor:self.myFlashSubL];
    [self setSubTitleColor:self.myAppoinmentSubL];
    [self setSubTitleColor:self.shareMakeMoneySubL];
    [self setSubTitleColor:self.bringUpHeadlineSubL];
    [self setSubTitleColor:self.customerServicesSubL];
    [self setSubTitleColor:self.opinionSubL];
    
    self.VLineOneH.constant = LINE_H;
    self.VLineTwoH.constant = LINE_H;
    self.VLineThreeH.constant = LINE_H;
    self.VLineFourH.constant = LINE_H;
    self.HLineOneH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    self.HLineThreeH.constant = LINE_H;
    self.HLineFourH.constant = LINE_H;
    
    self.radishTipL.backgroundColor = COLOR_PINK;
    self.flashTipL.backgroundColor = COLOR_PINK;
    self.appoinmentTipL.backgroundColor = COLOR_PINK;
    self.shareTipL.backgroundColor = COLOR_PINK;
    self.radishTipL.layer.cornerRadius = CGRectGetHeight(self.radishTipL.frame) * 0.5;
    self.radishTipL.layer.masksToBounds = YES;
    self.flashTipL.layer.cornerRadius = CGRectGetHeight(self.flashTipL.frame) * 0.5;
    self.flashTipL.layer.masksToBounds = YES;
    self.appoinmentTipL.layer.cornerRadius = CGRectGetHeight(self.appoinmentTipL.frame) * 0.5;
    self.appoinmentTipL.layer.masksToBounds = YES;
    self.shareTipL.layer.cornerRadius = CGRectGetHeight(self.shareTipL.frame) * 0.5;
    self.shareTipL.layer.masksToBounds = YES;
    
    [self layoutIfNeeded];
}

- (void)setTitleColor:(UILabel *)label {
    label.textColor = [UIColor colorFromHexString:@"444444"];
}

- (void)setSubTitleColor:(UILabel *)label {
    label.textColor = [UIColor colorFromHexString:@"A9A9A9"];
}

- (IBAction)action:(UIButton *)sender {
    AccountCenterCellActionType type = sender.tag;
    switch (type) {
        case AccountCenterCellActionTypeRadishMall:
        {
            self.radishTipL.hidden = YES;
        }
            break;
        case AccountCenterCellActionTypeShareMakeMoney:
        {
            self.shareTipL.hidden = YES;
        }
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    AccountCenterUserCount *userCount = model.data.userCount;
    self.flashTipL.hidden = !userCount.userHasNewFlashProduct;
    self.appoinmentTipL.hidden = !userCount.userHasNewAppointmentOrder;
    
}

@end
