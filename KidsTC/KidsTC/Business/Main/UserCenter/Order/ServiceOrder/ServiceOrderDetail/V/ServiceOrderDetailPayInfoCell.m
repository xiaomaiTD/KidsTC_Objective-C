//
//  ServiceOrderDetailPayInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailPayInfoCell.h"

@interface ServiceOrderDetailPayInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation ServiceOrderDetailPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.subLabel.textColor = COLOR_YELL;
    self.priceLabel.textColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
}
- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    NSString *tip, *sub, *price;
    switch (self.type) {
        case ServiceOrderDetailPayInfoCellTypeTypePrice:
        {
            tip = @"商品金额";
            sub = nil;
            price = [NSString stringWithFormat:@"¥%.1f",data.price * data.count];
        }
            break;
        case ServiceOrderDetailPayInfoCellTypeTypePromotion:
        {
            tip = @"优惠";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.1f",data.discountAmt];
        }
            break;
        case ServiceOrderDetailPayInfoCellTypeTypeScore:
        {
            tip = @"积分";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.1f",data.scoreNum/10.0];
        }
            break;
        case ServiceOrderDetailPayInfoCellTypeTransportationExpenses:
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
