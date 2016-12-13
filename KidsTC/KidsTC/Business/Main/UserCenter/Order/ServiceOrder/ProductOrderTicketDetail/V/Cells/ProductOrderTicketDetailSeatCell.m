//
//  ProductOrderTicketDetailSeatCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailSeatCell.h"

@interface ProductOrderTicketDetailSeatCell ()
@property (weak, nonatomic) IBOutlet UILabel *seatL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@end

@implementation ProductOrderTicketDetailSeatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductOrderTicketDetailData *)data {
    [super setData:data];
    NSInteger tag = self.tag;
    if (tag>=0&&tag<data.seats.count) {
        ProductOrderTicketDetailSeat *seat = data.seats[tag];
        self.seatL.text = seat.seat;
        self.numL.text = [NSString stringWithFormat:@"%@张",seat.num];
        self.priceL.text = [NSString stringWithFormat:@"%@元",seat.price];
    }
}


@end
