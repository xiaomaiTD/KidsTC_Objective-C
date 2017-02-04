//
//  RadishOrderDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailAddressCell.h"

@interface RadishOrderDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

@end

@implementation RadishOrderDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    RadishOrderDetailUserAddress *userAddress = self.data.userAddress;
    self.nameL.text = [NSString stringWithFormat:@"%@  %@",userAddress.peopleName,userAddress.mobileNumber];
    self.addressL.text = userAddress.fullAddress;
}

@end
