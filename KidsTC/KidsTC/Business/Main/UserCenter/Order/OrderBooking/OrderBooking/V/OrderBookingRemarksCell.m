//
//  OrderBookingRemarksCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingRemarksCell.h"

@interface OrderBookingRemarksCell ()
@property (weak, nonatomic) IBOutlet UILabel *remarksLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation OrderBookingRemarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(OrderBookingData *)data {
    [super setData:data];
    self.remarksLabel.attributedText = data.supplierRemarkStr;
}

@end
