//
//  FlashBuyProductDetailPriceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailPriceCell.h"

@interface FlashBuyProductDetailPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *storePriceL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *joinNumL;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation FlashBuyProductDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    [self layoutIfNeeded];
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    self.storePriceL.text = [NSString stringWithFormat:@"门店价:%@元",data.price];
    self.priceL.text = [NSString stringWithFormat:@"预付:%@元",data.prepaidPrice];
    self.joinNumL.text = [NSString stringWithFormat:@"%zd",data.prepaidNum];
    self.commentNumL.text = [NSString stringWithFormat:@"%zd",data.evaluate];
}

@end
