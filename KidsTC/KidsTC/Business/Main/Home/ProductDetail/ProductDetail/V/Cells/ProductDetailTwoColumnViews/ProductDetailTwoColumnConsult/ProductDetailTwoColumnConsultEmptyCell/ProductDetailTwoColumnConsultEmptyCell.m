//
//  ProductDetailTwoColumnConsultEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnConsultEmptyCell.h"

@interface ProductDetailTwoColumnConsultEmptyCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTwoColumnConsultEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.backgroundColor = PRODUCT_DETAIL_BLUE;
    self.btn.tag = ProductDetailBaseCellActionTypeAddNewConsult;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
