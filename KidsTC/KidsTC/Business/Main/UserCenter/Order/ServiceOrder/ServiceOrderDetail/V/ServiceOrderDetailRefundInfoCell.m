//
//  ServiceOrderDetailRefundInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailRefundInfoCell.h"

@interface ServiceOrderDetailRefundInfoCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *refundDescLabel;
@end

@implementation ServiceOrderDetailRefundInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    NSInteger tag = self.tag;
    if (tag>=0&&tag<data.refunds.count) {
        ServiceOrderDetailRefund *refund = data.refunds[tag];
        self.refundDescLabel.attributedText = refund.refundDescStr;
    }
}
@end
