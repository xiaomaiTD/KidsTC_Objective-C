//
//  ProductDetailTwoColumnConsultTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnConsultTipCell.h"

@interface ProductDetailTwoColumnConsultTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipNumL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTwoColumnConsultTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    self.btn.tag = ProductDetailBaseCellActionTypeAddNewConsult;
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    NSInteger count = data.advisoryCount;
    NSString *consultTitle = count>0 ? [NSString stringWithFormat:@"活动咨询(%zd)",count]:@"活动咨询";
    self.tipNumL.text = consultTitle;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
