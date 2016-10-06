//
//  FlashAdvanceSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementStoreInfoCell.h"

@interface FlashAdvanceSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;
@end

@implementation FlashAdvanceSettlementStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstranitHeight.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    self.storeDescLabel.attributedText = data.storeInfo.storeDesc;
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flashAdvanceSettlementBaseCell:actionType:value:)]) {
        [self.delegate flashAdvanceSettlementBaseCell:self actionType:FlashAdvanceSettlementBaseCellActionTypeStoreInfo value:nil];
    }
}

@end
