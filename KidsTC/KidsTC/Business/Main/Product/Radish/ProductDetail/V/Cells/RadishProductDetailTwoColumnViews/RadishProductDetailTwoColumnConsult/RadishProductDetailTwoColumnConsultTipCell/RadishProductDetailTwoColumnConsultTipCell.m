//
//  RadishProductDetailTwoColumnConsultTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTwoColumnConsultTipCell.h"

@interface RadishProductDetailTwoColumnConsultTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipNumL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RadishProductDetailTwoColumnConsultTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    self.btn.tag = RadishProductDetailBaseCellActionTypeAddNewConsult;
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    NSInteger count = data.advisoryCount;
    NSString *consultTitle = count>0 ? [NSString stringWithFormat:@"活动咨询(%zd)",count]:@"活动咨询";
    self.tipNumL.text = consultTitle;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


@end
