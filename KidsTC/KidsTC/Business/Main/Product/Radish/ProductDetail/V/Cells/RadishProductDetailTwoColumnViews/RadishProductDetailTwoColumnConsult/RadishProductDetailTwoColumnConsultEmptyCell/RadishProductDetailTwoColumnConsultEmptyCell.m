//
//  RadishProductDetailTwoColumnConsultEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTwoColumnConsultEmptyCell.h"

@interface RadishProductDetailTwoColumnConsultEmptyCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RadishProductDetailTwoColumnConsultEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.backgroundColor = PRODUCT_DETAIL_BLUE;
    self.btn.tag = RadishProductDetailBaseCellActionTypeAddNewConsult;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
