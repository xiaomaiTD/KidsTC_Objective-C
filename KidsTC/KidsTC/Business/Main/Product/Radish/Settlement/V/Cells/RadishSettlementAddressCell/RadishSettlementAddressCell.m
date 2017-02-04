//
//  RadishSettlementAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "RadishSettlementAddressCell.h"

@interface RadishSettlementAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation RadishSettlementAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(radishSettlementBaseCell:actionType:value:)]) {
        [self.delegate radishSettlementBaseCell:self actionType:RadishSettlementBaseCellActionTypeAddress value:nil];
    }
}

- (void)setData:(RadishSettlementData *)data {
    [super setData:data];
    UserAddressManageDataItem *userAddress = data.userAddressInfo;
    if (userAddress) {
        self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobile];
        self.addressLabel.text = userAddress.addressDescription;
    }
}

@end
