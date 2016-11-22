//
//  ServiceSettlementToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementToolBar.h"
#import "Colours.h"

CGFloat const kServiceSettlementToolBarH = 49;

@interface ServiceSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIView *Hline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ServiceSettlementToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.tipL.textColor = [UIColor colorFromHexString:@"323333"];
    self.priceL.textColor = COLOR_PINK;
    self.commitBtn.backgroundColor = COLOR_PINK;
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self layoutIfNeeded];
    
    self.commitBtn.tag = ServiceSettlementToolBarActionTypeCommit;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    _item = item;
    self.hidden = _item == nil;
    if (!self.hidden) {
        self.priceL.text = [NSString stringWithFormat:@"¥%@",_item.totalPrice];
    }
}

- (IBAction)commit:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementToolBar:actionType:value:)]) {
        [self.delegate serviceSettlementToolBar:self actionType:sender.tag value:nil];
    }
}
@end
