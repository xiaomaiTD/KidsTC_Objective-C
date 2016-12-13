//
//  ProductOrderTicketDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailAddressCell.h"

@interface ProductOrderTicketDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

@end

@implementation ProductOrderTicketDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    ProductOrderTicketDetailUserAddress *userAddress = self.data.userAddressInfo;
    self.nameL.text = [NSString stringWithFormat:@"%@  %@",userAddress.peopleName,userAddress.mobile];
    self.addressL.text = userAddress.fullAddress;
}

@end
