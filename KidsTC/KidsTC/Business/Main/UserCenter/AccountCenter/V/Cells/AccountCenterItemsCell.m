//
//  AccountCenterItemsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterItemsCell.h"

@interface AccountCenterItemsCell ()
@property (weak, nonatomic) IBOutlet UIButton *historyBtn;
@property (weak, nonatomic) IBOutlet UIButton *radishMallBtn;
@property (weak, nonatomic) IBOutlet UIButton *myFlashBtn;
@property (weak, nonatomic) IBOutlet UIButton *myAppoinmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareMakeMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *bringUpHeadlineBtn;
@property (weak, nonatomic) IBOutlet UIButton *customerServicesBtn;
@property (weak, nonatomic) IBOutlet UIButton *opinionBtn;

@end

@implementation AccountCenterItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.historyBtn.tag = AccountCenterCellActionTypeHistory;
    self.radishMallBtn.tag = AccountCenterCellActionTypeRadishMall;
    self.myFlashBtn.tag = AccountCenterCellActionTypeMyFlash;
    self.myAppoinmentBtn.tag = AccountCenterCellActionTypeMyAppoinment;
    self.shareMakeMoneyBtn.tag = AccountCenterCellActionTypeShareMakeMoney;
    self.bringUpHeadlineBtn.tag = AccountCenterCellActionTypeBringUpHeadline;
    self.customerServicesBtn.tag = AccountCenterCellActionTypeCustomerServices;
    self.opinionBtn.tag = AccountCenterCellActionTypeOpinion;
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
}

@end
