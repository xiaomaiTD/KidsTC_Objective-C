//
//  FlashBalanceSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementStoreInfoCell.h"

@interface FlashBalanceSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;
@end

@implementation FlashBalanceSettlementStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstranitHeight.constant = LINE_H;
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    self.storeDescLabel.attributedText = data.storeInfo.storeDesc;
}

@end
