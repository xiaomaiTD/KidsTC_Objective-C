//
//  RadishProductDetailPriceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailPriceCell.h"

@interface RadishProductDetailPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation RadishProductDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    self.countL.text = [NSString stringWithFormat:@"%@根",data.radishCount];
    self.priceL.text = [NSString stringWithFormat:@"+%@元",data.price];
    self.priceL.hidden = !data.isShowPrice;
    self.originalPriceL.text = [NSString stringWithFormat:@"童成价：¥%@",data.originalPrice];
}

@end
