//
//  ServiceOrderDetailAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailAddressCell.h"

@interface ServiceOrderDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation ServiceOrderDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    ServiceOrderDetailUserAddress *userAddress = data.userAddress;
    self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobileNumber];
    self.addressLabel.text = userAddress.fullAddress;
}


@end
