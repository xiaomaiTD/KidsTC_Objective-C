//
//  WholesalePickDateToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesalePickDateToolBar.h"

@interface WholesalePickDateToolBar ()
@property (weak, nonatomic) IBOutlet UIView *priceBGVeiw;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WholesalePickDateToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceBGVeiw.hidden = YES;
}

- (void)setTime:(WholesalePickDateTime *)time {
    _time = time;
    self.priceBGVeiw.hidden = time==nil;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",time.price];
    self.btn.enabled = time.canBuy;
    self.btn.backgroundColor = time.canBuy?[UIColor colorFromHexString:@"FF8888"]:[UIColor lightGrayColor];
    self.btn.tag = WholesalePickDateToolBarActionTypeBuy;
}

- (void)setType:(WholesalePickDateSKUBtnType)type {
    _type = type;
    switch (type) {
        case WholesalePickDateSKUBtnTypeBuy:
        {
            [self.btn setTitle:@"立即购买" forState:UIControlStateNormal];
            //self.btn.tag = WholesalePickDateToolBarActionTypeBuy;
        }
            break;
        case WholesalePickDateSKUBtnTypeMakeSure:
        {
            [self.btn setTitle:@"确定" forState:UIControlStateNormal];
            //self.btn.tag = WholesalePickDateToolBarActionTypeMakeSure;
        }
            break;
        default:
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wholesalePickDateToolBar:actionType:value:)]) {
        [self.delegate wholesalePickDateToolBar:self actionType:(WholesalePickDateToolBarActionType)self.type value:self.time];
    }
}

@end
