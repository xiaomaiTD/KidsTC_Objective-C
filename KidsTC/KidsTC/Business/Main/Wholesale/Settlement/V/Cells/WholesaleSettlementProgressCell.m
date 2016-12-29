//
//  WholesaleSettlementProgressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementProgressCell.h"

@interface WholesaleSettlementProgressCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WholesaleSettlementProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
}

@end
