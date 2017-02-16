//
//  ScoreEarnExchangeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnExchangeCell.h"

@interface ScoreEarnExchangeCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UILabel *scoreCountL;
@property (weak, nonatomic) IBOutlet UIButton *plantBtn;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@end

@implementation ScoreEarnExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.plantBtn.tag = ScoreEarnBaseCellActionTypePlant;
    self.exchangeBtn.tag = ScoreEarnBaseCellActionTypeExchange;
    [self.exchangeBtn setImage:[UIImage imageNamed:@"Score_exchange_01"] forState:UIControlStateNormal];
    [self.exchangeBtn setImage:[UIImage imageNamed:@"Score_exchange_01_un"] forState:UIControlStateDisabled];
}

- (void)setItem:(ScoreEarnShowItem *)item {
    [super setItem:item];
    ScoreUserInfoData *userInfoData = self.userInfoData;
    self.exchangeBtn.enabled = userInfoData.canMaxScore>0;
    self.radishCountL.text = [NSString stringWithFormat:@"%@根",@(userInfoData.canMaxScore*userInfoData.radishExchangeRate)];
    self.scoreCountL.text = [NSString stringWithFormat:@"%@积分",@(userInfoData.canMaxScore)];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scoreEarnBaseCell:actionType:value:)]) {
        [self.delegate scoreEarnBaseCell:self actionType:(ScoreEarnBaseCellActionType)sender.tag value:nil];
    }
}


@end
