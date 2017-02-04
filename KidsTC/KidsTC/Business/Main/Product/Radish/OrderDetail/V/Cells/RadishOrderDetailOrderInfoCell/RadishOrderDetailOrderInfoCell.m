//
//  RadishOrderDetailOrderInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailOrderInfoCell.h"

@interface RadishOrderDetailOrderInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@end

@implementation RadishOrderDetailOrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    self.contentL.attributedText = data.orderInfoStr;
}

@end
