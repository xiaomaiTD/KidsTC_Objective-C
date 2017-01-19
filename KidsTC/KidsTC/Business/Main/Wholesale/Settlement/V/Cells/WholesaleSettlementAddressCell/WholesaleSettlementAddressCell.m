//
//  WholesaleSettlementAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WholesaleSettlementAddressCell.h"


@interface WholesaleSettlementAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation WholesaleSettlementAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
        [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeAddress value:nil];
    }
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    UserAddressManageDataItem *userAddress = data.userAddressInfo;
    if (userAddress) {
        self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobile];
        self.addressLabel.text = userAddress.addressDescription;
    }
}

@end
