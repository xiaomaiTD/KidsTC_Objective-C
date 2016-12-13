//
//  ProductOrderNormalDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailAddressCell.h"

@interface ProductOrderNormalDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

@end

@implementation ProductOrderNormalDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    ProductOrderNormalDetailUserAddress *userAddress = self.data.userAddress;
    self.nameL.text = [NSString stringWithFormat:@"%@  %@",userAddress.peopleName,userAddress.mobileNumber];
    self.addressL.text = userAddress.fullAddress;
}

@end
