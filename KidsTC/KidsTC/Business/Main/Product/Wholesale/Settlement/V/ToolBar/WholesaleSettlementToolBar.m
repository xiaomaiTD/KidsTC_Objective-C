//
//  WholesaleSettlementToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementToolBar.h"

CGFloat const kWholesaleSettlementToolBarH = 77;

@interface WholesaleSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIView *addressBGView;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation WholesaleSettlementToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.addressBGView.hidden = YES;
}

- (void)setAddressBGViewHide:(BOOL)hide {
    self.addressBGView.hidden = hide;
}

- (void)setData:(WholesaleSettlementData *)data {
    _data = data;
    self.hidden = data == nil;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.fightGroupPrice];
    NSString *title = data.isOpen?@"我要开团":@"我要参团";
    [self.btn setTitle:title forState:UIControlStateNormal];
    self.addressL.text = [NSString stringWithFormat:@"送至：%@",data.userAddressInfo.addressDescription];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickWholesaleSettlementToolBar:)]) {
        [self.delegate didClickWholesaleSettlementToolBar:self];
    }
}
@end
