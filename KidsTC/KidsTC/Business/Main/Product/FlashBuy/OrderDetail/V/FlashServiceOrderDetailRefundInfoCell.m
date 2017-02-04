//
//  FlashServiceOrderDetailRefundInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailRefundInfoCell.h"

@interface FlashServiceOrderDetailRefundInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *refundDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation FlashServiceOrderDetailRefundInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    NSInteger tag = self.tag;
    if (tag>=0&&tag<data.refunds.count) {
        FlashServiceOrderDetailRefund *refund = data.refunds[tag];
        self.refundDescLabel.attributedText = refund.refundDescStr;
    }
}

@end
