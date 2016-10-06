//
//  ServiceSettlementAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementAddressCell.h"


@interface ServiceSettlementAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ServiceSettlementAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeAddress value:nil];
    }
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    UserAddressManageDataItem *userAddress = item.userAddress;
    if (userAddress) {
        self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobile];
        self.addressLabel.text = userAddress.addressDescription;
    }
}

@end
