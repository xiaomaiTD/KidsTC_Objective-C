//
//  ProductDetailTwoColumnConsultMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnConsultMoreCell.h"

@interface ProductDetailTwoColumnConsultMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end

@implementation ProductDetailTwoColumnConsultMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreBtn.layer.borderWidth = LINE_H;
    self.moreBtn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    [self.moreBtn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.moreBtn.tag = ProductDetailBaseCellActionTypeMoreConsult;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
