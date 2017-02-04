//
//  FlashBalanceSettlementAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementAddressCell.h"

@interface FlashBalanceSettlementAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation FlashBalanceSettlementAddressCell


-(void)setData:(FlashSettlementData *)data{
    [super setData:data];
    UserAddressManageDataItem *userAddress = data.userAddress;
    if (userAddress) {
        self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobile];
        self.addressLabel.text = userAddress.addressDescription;
    }
}


@end
