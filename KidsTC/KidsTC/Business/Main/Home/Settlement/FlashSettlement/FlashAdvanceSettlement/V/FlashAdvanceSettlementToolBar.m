//
//  FlashAdvanceSettlementToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementToolBar.h"

@interface FlashAdvanceSettlementToolBar ()

@end

@implementation FlashAdvanceSettlementToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.label.textColor = COLOR_PINK;
    self.btn.backgroundColor = COLOR_PINK;
    self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.layer.borderWidth = LINE_H;
}

- (void)setModel:(FlashSettlementModel *)model{
    _model = model;
    self.label.text = [NSString stringWithFormat:@"实付款：¥%0.1f",model.data.price];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}


@end
