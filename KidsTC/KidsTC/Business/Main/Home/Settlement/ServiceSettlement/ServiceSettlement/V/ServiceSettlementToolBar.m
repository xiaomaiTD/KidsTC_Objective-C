//
//  ServiceSettlementToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementToolBar.h"
#import "Colours.h"

CGFloat const kServiceSettlementToolBarH = 77;

@interface ServiceSettlementToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIView *Hline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@property (weak, nonatomic) IBOutlet UIView *addressBGView;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

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
    self.addressBGView.hidden = YES;
    self.commitBtn.tag = ServiceSettlementToolBarActionTypeCommit;
}

- (void)setAddressBGViewHide:(BOOL)hide {
    self.addressBGView.hidden = hide;
}

- (void)setItem:(ServiceSettlementDataItem *)item {
    _item = item;
    self.hidden = _item == nil;
    switch (self.item.type) {
        case ProductDetailTypeNormal:
        {
            self.priceL.text = [NSString stringWithFormat:@"¥%@",_item.totalPrice];
        }
            break;
        case ProductDetailTypeTicket:
        {
            self.priceL.text = [NSString stringWithFormat:@"¥%@",_item.payPrice];
        }
            break;
        default:
        {
            self.priceL.text = [NSString stringWithFormat:@"¥%@",_item.totalPrice];
        }
            break;
    }
    self.addressL.text = [NSString stringWithFormat:@"送至：%@",_item.userAddress.addressDescription];
}

- (IBAction)commit:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementToolBar:actionType:value:)]) {
        [self.delegate serviceSettlementToolBar:self actionType:sender.tag value:nil];
    }
}
@end
