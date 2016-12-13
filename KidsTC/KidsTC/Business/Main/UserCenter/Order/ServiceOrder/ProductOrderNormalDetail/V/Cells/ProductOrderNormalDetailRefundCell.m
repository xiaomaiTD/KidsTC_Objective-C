//
//  ProductOrderNormalDetailRefundCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailRefundCell.h"

@interface ProductOrderNormalDetailRefundCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@end

@implementation ProductOrderNormalDetailRefundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    NSInteger tag = self.tag;
    if (tag>=0&&tag<data.refunds.count) {
        ProductOrderNormalDetailRefund *refund = data.refunds[tag];
        self.contentL.attributedText = refund.refundDescStr;
    }
}

@end
