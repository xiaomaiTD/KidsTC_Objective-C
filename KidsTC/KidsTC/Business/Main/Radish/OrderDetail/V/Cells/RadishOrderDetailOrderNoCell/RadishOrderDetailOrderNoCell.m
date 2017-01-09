//
//  RadishOrderDetailOrderNoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailOrderNoCell.h"

@interface RadishOrderDetailOrderNoCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNoL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@end

@implementation RadishOrderDetailOrderNoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    self.orderNoL.text = self.data.orderId;
    self.statusL.text = self.data.orderStateName;
}

@end
