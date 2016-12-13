//
//  ProductOrderTicketDetailPayInfoTotalCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailPayInfoTotalCell.h"

@interface ProductOrderTicketDetailPayInfoTotalCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderTicketDetailPayInfoTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.payPrice];
    self.timeL.text = [NSString stringWithFormat:@"下单时间：%@",data.createTime];
}

@end
