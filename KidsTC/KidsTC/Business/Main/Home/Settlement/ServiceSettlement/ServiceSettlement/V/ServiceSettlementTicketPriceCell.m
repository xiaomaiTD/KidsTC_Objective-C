//
//  ServiceSettlementTicketPriceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementTicketPriceCell.h"
#import "Colours.h"

@interface ServiceSettlementTicketPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation ServiceSettlementTicketPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleL.textColor = [UIColor colorFromHexString:@"555555"];
    self.priceL.textColor = COLOR_PINK;
}

- (void)setSeat:(ServiceSettlementSeat *)seat {
    _seat = seat;
    
    self.titleL.text = _seat.seat;
    self.priceL.text = [NSString stringWithFormat:@"%@元",_seat.price];
}

@end
