//
//  RadishOrderDetailPayInfoTotalCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailPayInfoTotalCell.h"

@interface RadishOrderDetailPayInfoTotalCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation RadishOrderDetailPayInfoTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.totalPrice];
    self.timeL.text = [NSString stringWithFormat:@"下单时间：%@",data.time];
}

@end
