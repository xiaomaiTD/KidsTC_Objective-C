//
//  ProductOrderTicketDetailTheatherAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailTheatherAddressCell.h"

@interface ProductOrderTicketDetailTheatherAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderTicketDetailTheatherAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    self.nameL.text = data.theater;
    self.addressL.text = data.address;
}

@end
