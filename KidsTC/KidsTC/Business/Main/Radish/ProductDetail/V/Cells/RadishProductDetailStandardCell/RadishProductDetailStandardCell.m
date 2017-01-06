//
//  RadishProductDetailStandardCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailStandardCell.h"
#import "UIButton+Category.h"

@interface RadishProductDetailStandardCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation RadishProductDetailStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    
    self.buyBtn.backgroundColor = PRODUCT_DETAIL_RED;
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
    [self.buyBtn setBackgroundColor:PRODUCT_DETAIL_RED forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.contentL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    if (_index<data.product_standards.count) {
        RadishProductDetailStandard *standard = data.product_standards[_index];
        self.nameL.text = standard.productName;
        self.contentL.text = standard.productContent;
        self.priceL.text = standard.priceStr;
        self.buyBtn.enabled = standard.isCanBuy;
        [self.buyBtn setTitle:standard.statusDesc forState:UIControlStateNormal];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if (_index<self.data.product_standards.count) {
        if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
            [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeStandard value:self.data.product_standards[_index]];
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    if (_index<self.data.product_standards.count) {
        if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
            [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeBuyStandard value:self.data.product_standards[_index]];
        }
    }
}
@end
