//
//  ProductOrderTicketDetailOrderNoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailOrderNoCell.h"

@interface ProductOrderTicketDetailOrderNoCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNoL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@end

@implementation ProductOrderTicketDetailOrderNoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    self.orderNoL.text = self.data.orderNo;
    self.statusL.text = self.data.orderStatusDesc;
}

@end
