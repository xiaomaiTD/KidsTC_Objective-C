//
//  ServiceSettlementBaseCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementBaseCell.h"

NSString *const KServiceSettlementUserRemark = @"ServiceSettlementUserRemark";

@implementation ServiceSettlementBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
