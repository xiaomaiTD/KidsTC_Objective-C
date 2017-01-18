//
//  WholesaleSettlementRuleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementRuleCell.h"

@interface WholesaleSettlementRuleCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation WholesaleSettlementRuleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
        [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeRule value:nil];
    }
}


@end
