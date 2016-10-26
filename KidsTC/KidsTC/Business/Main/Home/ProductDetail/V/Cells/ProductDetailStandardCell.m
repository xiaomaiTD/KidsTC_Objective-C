//
//  ProductDetailStandardCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailStandardCell.h"
#import "UIButton+Category.h"

@interface ProductDetailStandardCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation ProductDetailStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    
    self.buyBtn.backgroundColor = PRODUCT_DETAIL_RED;
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
    [self.buyBtn setBackgroundColor:PRODUCT_DETAIL_RED forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (_index<data.product_standards.count) {
        ProductDetailStandard *standard = data.product_standards[_index];
        self.nameL.text = standard.productName;
        self.contentL.text = standard.productContent;
        self.priceL.text = standard.priceStr;
        self.buyBtn.enabled = standard.isCanBuy;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

@end
