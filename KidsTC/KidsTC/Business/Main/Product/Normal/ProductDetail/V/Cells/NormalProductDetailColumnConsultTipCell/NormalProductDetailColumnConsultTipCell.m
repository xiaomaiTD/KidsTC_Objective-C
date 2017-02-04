//
//  NormalProductDetailColumnConsultTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailColumnConsultTipCell.h"

@interface NormalProductDetailColumnConsultTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipNumL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation NormalProductDetailColumnConsultTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
}

- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    NSInteger count = data.advisoryCount;
    NSString *consultTitle = count>0 ? [NSString stringWithFormat:@"活动咨询(%zd)",count]:@"活动咨询";
    self.tipNumL.text = consultTitle;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeAddNewConsult value:nil];
    }
}


@end
