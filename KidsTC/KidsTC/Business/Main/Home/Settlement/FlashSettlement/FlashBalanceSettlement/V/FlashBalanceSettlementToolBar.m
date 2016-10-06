//
//  FlashBalanceSettlementToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementToolBar.h"

@interface FlashBalanceSettlementToolBar ()

@end

@implementation FlashBalanceSettlementToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    self.priceLabel.textColor = COLOR_PINK;
    self.btn.backgroundColor = COLOR_PINK;
    self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.layer.borderWidth = LINE_H;
}

- (void)setData:(FlashSettlementData *)data{
    _data = data;
    CGFloat price = data.price - data.useScoreNum/10.0;
    if (price<0) price = 0;
    self.priceLabel.text = [NSString stringWithFormat:@"实付款：¥%0.1f",price];
    NSString *btnTitle = price>0?@"确认支付":@"确认提交";
    [self.btn setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}

@end
