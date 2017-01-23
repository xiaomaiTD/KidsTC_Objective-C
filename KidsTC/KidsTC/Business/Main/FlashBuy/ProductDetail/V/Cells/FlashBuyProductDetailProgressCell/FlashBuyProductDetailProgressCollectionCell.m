//
//  FlashBuyProductDetailProgressCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailProgressCollectionCell.h"

@interface FlashBuyProductDetailProgressCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceTipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;

@end

@implementation FlashBuyProductDetailProgressCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setConfig:(FlashBuyProductDetailPriceConfig *)config {
    _config = config;
    
    NSString *statusImageStr = nil;
    NSString *priceColorStr = nil;
    switch (config.priceStatus) {
        case FlashBuyProductDetailPriceConfigCurrentAchieved:
        {
            statusImageStr = @"priceState-1";
            priceColorStr = @"ff99b6";
        }
            break;
            
        default:
        {
            statusImageStr = @"priceState-0";
            priceColorStr = @"cccccc";
        }
            break;
    }
    UIColor *priceColor = [UIColor colorFromHexString:priceColorStr];
    self.priceTipL.textColor = priceColor;
    self.priceL.textColor = priceColor;
    self.statusImageView.image = [UIImage imageNamed:statusImageStr];
    
    self.priceL.text = config.price;
    self.numL.text = [NSString stringWithFormat:@"%zd人闪购价",config.peopleNum];
    self.statusL.text = config.priceStatusName;
}

@end
