//
//  WholesaleSettlementAddressTipCell.m
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WholesaleSettlementAddressTipCell.h"

@implementation WholesaleSettlementAddressTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)tagGR {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
        [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeAddressTip value:nil];
    }
}

@end
