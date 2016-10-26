//
//  ProductDetailInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailInfoCell.h"

@interface ProductDetailInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;
@property (weak, nonatomic) IBOutlet UILabel *saleNumL;
@end

@implementation ProductDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    self.commentNumL.textColor = PRODUCT_DETAIL_BLUE;
    self.saleNumL.textColor = PRODUCT_DETAIL_BLUE;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.nameL.attributedText = data.attServeName;
    self.contentL.attributedText = data.attPromote;
    self.priceL.text = data.priceStr;
    self.commentNumL.text = [NSString stringWithFormat:@"%zd",data.evaluate];
    self.saleNumL.text = [NSString stringWithFormat:@"%zd",data.saleCount];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
