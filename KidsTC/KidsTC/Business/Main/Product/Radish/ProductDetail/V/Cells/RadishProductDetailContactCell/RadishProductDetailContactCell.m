//
//  RadishProductDetailContactCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailContactCell.h"


@interface RadishProductDetailContactCell ()
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@end

@implementation RadishProductDetailContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self setupBtn:self.consultBtn];
    [self setupBtn:self.contactBtn];
}

- (void)setupBtn:(UIButton *)btn {
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    
}

- (IBAction)consult:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeConsult value:nil];
    }
}

- (IBAction)contact:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeContact value:self.data.store];
    }
}
@end
