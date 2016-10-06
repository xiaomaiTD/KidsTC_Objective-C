//
//  FlashServiceOrderDetailAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailAddressCell.h"

@interface FlashServiceOrderDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation FlashServiceOrderDetailAddressCell

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    FlashServiceOrderDetailUserAddress *userAddress = data.userAddress;
    self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobileNumber];
    self.addressLabel.text = userAddress.fullAddress;
}

@end
