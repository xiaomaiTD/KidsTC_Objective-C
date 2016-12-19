//
//  ServiceSettlementPayInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementPayInfoCell.h"

@interface ServiceSettlementPayInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation ServiceSettlementPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipLabel.textColor = [UIColor colorFromHexString:@"222222"];
    self.subLabel.textColor = COLOR_YELL;
    self.priceLabel.textColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    [super setItem:item];
    NSString *tip, *sub, *price;
    switch (self.type) {
        case ServiceSettlementPayInfoCellTypePrice:
        {
            tip = @"商品金额";
            sub = nil;
            switch (self.item.type) {
                case ProductDetailTypeNormal:
                {
                    price = [NSString stringWithFormat:@"¥%.1f",[item.price floatValue] * item.count];
                }
                    break;
                case ProductDetailTypeTicket:
                {
                    price = item.totalPrice;
                }
                    break;
                default:
                {
                    price = [NSString stringWithFormat:@"¥%.1f",[item.price floatValue] * item.count];
                }
                    break;
            }
            
        }
            break;
        case ServiceSettlementPayInfoCellTypePromotion:
        {
            tip = @"优惠";
            if (item.maxCoupon) {
                sub = item.maxCoupon.desc;
                price = [NSString stringWithFormat:@"-¥%.1f",item.maxCoupon.couponAmt];
            }else{
                sub = item.promotion?item.promotion.fullcutdesc:@"";
                price = item.promotion?[NSString stringWithFormat:@"-¥%.2f",item.promotion.promotionamt]:@"-¥0.0";
            }
        }
            break;
        case ServiceSettlementPayInfoCellTypeScore:
        {
            tip = @"积分";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.2f",item.usescorenum/10.0];
        }
            break;
        case ServiceSettlementPayInfoCellTypeTransportationExpenses:
        {
            switch (self.item.type) {
                case ProductDetailTypeNormal:
                {
                    tip = item.isFreightDiscount?@"运费":@"运输优惠";
                    sub = nil;
                    price = [NSString stringWithFormat:@"%@¥%.2f",item.isFreightDiscount?@"":@"-",item.transportationExpenses];
                }
                    break;
                case ProductDetailTypeTicket:
                {
                    tip = @"运费";
                    sub = nil;
                    price = [NSString stringWithFormat:@"¥%.2f",item.transportationExpenses];
                }
                    break;
                default:
                {
                    tip = item.isFreightDiscount?@"运费":@"运输优惠";
                    sub = nil;
                    price = [NSString stringWithFormat:@"%@¥%.2f",item.isFreightDiscount?@"":@"-",item.transportationExpenses];
                }
                    break;
            }
            
        }
            break;
    }
    self.tipLabel.text = tip;
    self.subLabel.text = sub;
    self.priceLabel.text = price;
}

@end
