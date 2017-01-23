//
//  FlashAdvanceSettlementAddressCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementAddressCell.h"

@interface FlashAdvanceSettlementAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation FlashAdvanceSettlementAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

-(void)setData:(FlashSettlementData *)data{
    [super setData:data];
    UserAddressManageDataItem *userAddress = data.userAddress;
    if (userAddress) {
        self.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@    %@",userAddress.peopleName,userAddress.mobile];
        self.addressLabel.text = userAddress.addressDescription;
    }
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flashAdvanceSettlementBaseCell:actionType:value:)]) {
        [self.delegate flashAdvanceSettlementBaseCell:self actionType:FlashAdvanceSettlementBaseCellActionTypeAddress value:nil];
    }
}

@end
