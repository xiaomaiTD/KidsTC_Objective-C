//
//  ProductOrderNormalDetailPayInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailPayInfoCell.h"

@interface ProductOrderNormalDetailPayInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;
@end

@implementation ProductOrderNormalDetailPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.subTitleL.textColor = COLOR_YELL;
    self.priceL.textColor = COLOR_PINK;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    NSString *tip, *sub, *price;
    switch (self.type) {
        case ProductOrderNormalDetailPayInfoCellTypeTypePrice:
        {
            tip = @"商品金额";
            sub = nil;
            price = [NSString stringWithFormat:@"¥%.1f",[data.price floatValue] * data.count];
        }
            break;
        case ProductOrderNormalDetailPayInfoCellTypeTypePromotion:
        {
            tip = @"-优惠";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.1f",data.discountAmt];
        }
            break;
        case ProductOrderNormalDetailPayInfoCellTypeTypeScore:
        {
            tip = @"-积分";
            sub = nil;
            price = [NSString stringWithFormat:@"-¥%.1f",data.scoreNum/10.0];
        }
            break;
        case ProductOrderNormalDetailPayInfoCellTypeTransportationExpenses:
        {
            tip = data.isFreightDiscount?@"+运费":@"-运输优惠";
            sub = nil;
            price = [NSString stringWithFormat:@"%@¥%.1f",data.isFreightDiscount?@"":@"-",data.transportationExpenses];
        }
            break;
    }
    self.tipL.text = tip;
    self.subTitleL.text = sub;
    self.priceL.text = price;
}

@end
