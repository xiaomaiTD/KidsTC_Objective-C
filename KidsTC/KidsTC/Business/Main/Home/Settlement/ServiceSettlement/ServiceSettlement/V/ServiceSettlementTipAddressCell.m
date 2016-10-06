//
//  ServiceSettlementTipAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementTipAddressCell.h"

@implementation ServiceSettlementTipAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tagGR {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeTipAddress value:nil];
    }
}

@end
