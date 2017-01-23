//
//  FlashBalanceSettlementPayInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementPayInfoCell.h"

@interface FlashBalanceSettlementPayInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation FlashBalanceSettlementPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.subLabel.textColor = COLOR_YELL;
    self.priceLabel.textColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    NSString *tip, *sub, *price;
    switch (self.type) {
        case FlashBalanceSettlementPayInfoCellTypePrice:
        {
            tip = @"商品金额";
            sub = nil;
            price = [NSString stringWithFormat:@"¥%.1f",data.price];
        }
            break;
        case FlashBalanceSettlementPayInfoCellTypeScore:
        {
            tip = @"积分";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.1f",data.useScoreNum/10.0];
        }
            break;
        case FlashBalanceSettlementPayInfoCellTypeTransportationExpenses:
        {
            tip = data.isFreightDiscount?@"运费":@"运输优惠";
            sub = nil;
            price = [NSString stringWithFormat:@"%@¥%.1f",data.isFreightDiscount?@"":@"-",data.transportationExpenses];
        }
            break;
    }
    self.tipLabel.text = tip;
    self.subLabel.text = sub;
    self.priceLabel.text = price;
}


@end
