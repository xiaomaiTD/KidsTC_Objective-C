//
//  ServiceSettlementToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementToolBar.h"

CGFloat const kServiceSettlementToolBarH = 49;

@interface ServiceSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *priceTipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation ServiceSettlementToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    self.priceL.textColor = COLOR_PINK;
    self.commitBtn.backgroundColor = COLOR_PINK;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    _item = item;
    if (item) {
        self.hidden = NO;
    }
    self.priceL.text = [NSString stringWithFormat:@"¥%0.2f",item.totalPrice];
    NSString *btnTitle = item.totalPrice>0?@"确认支付":@"确认提交";
    [self.commitBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)commitAction:(UIButton *)sender {
    if (self.commitBlock) self.commitBlock();
}
@end
