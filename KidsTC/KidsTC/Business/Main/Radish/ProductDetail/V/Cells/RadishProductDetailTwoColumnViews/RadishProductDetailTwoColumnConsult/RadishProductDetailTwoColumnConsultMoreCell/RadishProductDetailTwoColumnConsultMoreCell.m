//
//  RadishProductDetailTwoColumnConsultMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTwoColumnConsultMoreCell.h"

@interface RadishProductDetailTwoColumnConsultMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end

@implementation RadishProductDetailTwoColumnConsultMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreBtn.layer.borderWidth = LINE_H;
    self.moreBtn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    [self.moreBtn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.moreBtn.tag = RadishProductDetailBaseCellActionTypeMoreConsult;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
