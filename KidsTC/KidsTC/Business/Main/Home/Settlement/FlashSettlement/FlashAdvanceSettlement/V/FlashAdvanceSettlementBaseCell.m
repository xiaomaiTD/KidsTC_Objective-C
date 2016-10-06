//
//  FlashAdvanceSettlementBaseCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementBaseCell.h"

@implementation FlashAdvanceSettlementBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
