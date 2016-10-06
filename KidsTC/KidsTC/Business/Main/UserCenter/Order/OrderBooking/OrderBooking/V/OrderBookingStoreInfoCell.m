//
//  OrderBookingStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingStoreInfoCell.h"

@interface OrderBookingStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation OrderBookingStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(OrderBookingData *)data {
    [super setData:data];
    
    _storeDescLabel.attributedText = data.storeInfo.storeDesc;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(orderBookingBaseCell:actionType:value:)]) {
        [self.delegate orderBookingBaseCell:self actionType:OrderBookingBaseCellActionTypeStoreInfo value:nil];
    }
}

@end
