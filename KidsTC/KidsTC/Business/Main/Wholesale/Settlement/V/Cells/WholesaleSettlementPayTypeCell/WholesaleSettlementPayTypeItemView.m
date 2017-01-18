//
//  WholesaleSettlementPayTypeItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementPayTypeItemView.h"

@interface WholesaleSettlementPayTypeItemView ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WholesaleSettlementPayTypeItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setSelect:(BOOL)select {
    _select = select;
    NSString *selectImgName = select?@"wholesale_pay_sel":@"wholesale_pay_unsel";
    self.selectImg.image = [UIImage imageNamed:selectImgName];
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    self.userInteractionEnabled = enable;
    self.alpha = enable?1:0.3;
    self.selectImg.image = [UIImage imageNamed:@"wholesale_pay_unsel"];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickWholesaleSettlementPayTypeItemView:)]) {
        [self.delegate didClickWholesaleSettlementPayTypeItemView:self];
    }
}

@end
