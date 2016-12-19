//
//  ProductDetailPriceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailPriceCell.h"

@interface ProductDetailPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;
@property (weak, nonatomic) IBOutlet UILabel *saleNumL;
@end

@implementation ProductDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    self.commentNumL.textColor = PRODUCT_DETAIL_BLUE;
    self.saleNumL.textColor = PRODUCT_DETAIL_BLUE;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.priceL.text = data.priceStr;
    self.commentNumL.text = [NSString stringWithFormat:@"%zd",data.evaluate];
    self.saleNumL.text = [NSString stringWithFormat:@"%zd",data.saleCount];
}

@end
