//
//  FlashAdvanceSettlementTipAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementTipAddressCell.h"

@implementation FlashAdvanceSettlementTipAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tagGR {
    
    if ([self.delegate respondsToSelector:@selector(flashAdvanceSettlementBaseCell:actionType:value:)]) {
        [self.delegate flashAdvanceSettlementBaseCell:self actionType:FlashAdvanceSettlementBaseCellActionTypeTipAddress value:nil];
    }
}

@end
