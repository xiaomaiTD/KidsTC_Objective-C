//
//  RadishSettlementTipAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "RadishSettlementTipAddressCell.h"

@implementation RadishSettlementTipAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tagGR {
    if ([self.delegate respondsToSelector:@selector(radishSettlementBaseCell:actionType:value:)]) {
        [self.delegate radishSettlementBaseCell:self actionType:RadishSettlementBaseCellActionTypeTipAddress value:nil];
    }
}

@end
