//
//  FlashBalanceSettlementScoreCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementScoreCell.h"

@interface FlashBalanceSettlementScoreCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *scoreBGView;
@property (weak, nonatomic) IBOutlet UILabel *scoreTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *scoreInputTf;
@property (weak, nonatomic) IBOutlet UILabel *useScoreTipLabel;
@end

@implementation FlashBalanceSettlementScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scoreInputTf.textColor = COLOR_PINK;
    self.scoreInputTf.layer.borderWidth = LINE_H;
    self.scoreInputTf.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];

    NSString *scorenumStr = [NSString stringWithFormat:@"%zd",data.maxScoreNum];
    NSString *scorenumTip = [NSString stringWithFormat:@"共%@积分可使用",scorenumStr];
    UIFont *font = [UIFont systemFontOfSize:15];
    NSDictionary *att = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:scorenumTip
                                                                              attributes:att];
    [attStr addAttribute:NSForegroundColorAttributeName value:COLOR_PINK range:[scorenumTip rangeOfString:scorenumStr]];
    self.scoreTipLabel.attributedText = attStr;
    
    self.scoreInputTf.hidden = !(data.maxScoreNum>0);
    if (!self.scoreInputTf.hidden) {
        self.scoreInputTf.text = @(data.useScoreNum).stringValue;
    }
    self.useScoreTipLabel.text = data.maxScoreNum>0?@"积分":@"不可使用";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(flashBalanceSettlementBaseCell:actionType:value:)]) {
        [self.delegate flashBalanceSettlementBaseCell:self actionType:FlashBalanceSettlementBaseCellActionTypeScore value:nil];
    }
    return NO;
}


@end
