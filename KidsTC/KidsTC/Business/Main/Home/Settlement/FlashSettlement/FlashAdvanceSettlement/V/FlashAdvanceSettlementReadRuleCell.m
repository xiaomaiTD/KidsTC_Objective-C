//
//  FlashAdvanceSettlementReadRuleCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementReadRuleCell.h"

@interface FlashAdvanceSettlementReadRuleCell ()
@property (weak, nonatomic) IBOutlet UIButton *checkRuleBtn;
@property (weak, nonatomic) IBOutlet UIButton *readRuleBtn;
@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation FlashAdvanceSettlementReadRuleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.readRuleBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    
    self.HLine.backgroundColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
    
    self.checkRuleBtn.tag = FlashAdvanceSettlementBaseCellActionTypeCheckRule;
    self.readRuleBtn.tag = FlashAdvanceSettlementBaseCellActionTypeReadRule;
    
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    self.checkRuleBtn.selected = !self.checkRuleBtn.selected;
    [self action:self.checkRuleBtn];
}

- (IBAction)action:(UIButton *)sender {
    if (sender == self.checkRuleBtn)sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(flashAdvanceSettlementBaseCell:actionType:value:)]){
        [self.delegate flashAdvanceSettlementBaseCell:self actionType:(FlashAdvanceSettlementBaseCellActionType)sender.tag value:@(sender.selected)];
    }
}

@end
