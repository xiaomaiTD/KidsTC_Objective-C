//
//  SettlementResultNewNormalCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewNormalCell.h"

@interface SettlementResultNewNormalCell ()
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *resultL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation SettlementResultNewNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCorner:self.goHomeBtn.layer];
    [self addCorner:self.showDetailBtn.layer];
    self.goHomeBtn.tag = SettlementResultNewBaseCellActionTypeGoHome;
    self.showDetailBtn.tag = SettlementResultNewBaseCellActionTypeOrderDetail;
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 1;
}

- (void)setPaid:(BOOL)paid {
    [super setPaid:paid];
    self.resultL.text = paid?@"您已支付成功！":@"支付失败！";
    self.tipL.text = paid?@"去玩吧，随便逛逛！":@"您可以查看订单，重新支付！";
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewBaseCell:actionType:value:)]) {
        [self.delegate settlementResultNewBaseCell:self actionType:sender.tag value:nil];
    }
}

@end
