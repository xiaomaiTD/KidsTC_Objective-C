//
//  RadishSettlementToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishSettlementToolBar.h"

CGFloat const kRadishSettlementToolBarH = 49;

@interface RadishSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation RadishSettlementToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishSettlementData *)data {
    _data = data;
    
    /*
    self.hidden = data == nil;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.fightGroupPrice];
    NSString *title = data.isOpen?@"我要开团":@"我要参团";
    [self.btn setTitle:title forState:UIControlStateNormal];
     */
}

- (IBAction)action:(UIButton *)sender {
    /*
    if ([self.delegate respondsToSelector:@selector(didClickRadishSettlementToolBar:)]) {
        [self.delegate didClickRadishSettlementToolBar:self];
    }
     */
}
@end
