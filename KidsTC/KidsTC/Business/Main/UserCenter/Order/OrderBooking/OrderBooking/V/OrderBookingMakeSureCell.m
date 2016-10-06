//
//  OrderBookingMakeSureCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingMakeSureCell.h"

@interface OrderBookingMakeSureCell ()
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;

@end

@implementation OrderBookingMakeSureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.makeSureBtn.backgroundColor = COLOR_PINK;
    
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderBookingBaseCell:actionType:value:)]) {
        [self.delegate orderBookingBaseCell:self actionType:OrderBookingBaseCellActionTypeMakeSure value:nil];
    }
}


@end
