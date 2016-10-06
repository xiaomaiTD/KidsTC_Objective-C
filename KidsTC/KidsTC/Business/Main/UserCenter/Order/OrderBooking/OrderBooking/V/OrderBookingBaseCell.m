//
//  OrderBookingBaseCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingBaseCell.h"

@interface OrderBookingBaseCell ()
@end

@implementation OrderBookingBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
