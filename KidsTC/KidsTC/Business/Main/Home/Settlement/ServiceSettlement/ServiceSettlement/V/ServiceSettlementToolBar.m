//
//  ServiceSettlementToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementToolBar.h"

@interface ServiceSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation ServiceSettlementToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    self.totalPriceLabel.textColor = COLOR_PINK;
    self.commitBtn.backgroundColor = COLOR_PINK;
    self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.layer.borderWidth = LINE_H;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    _item = item;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"总计：¥%0.1f",item.totalPrice];
    NSString *btnTitle = item.totalPrice>0?@"确认支付":@"确认提交";
    [self.commitBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)commitAction:(UIButton *)sender {
    if (self.commitBlock) self.commitBlock();
}
@end
