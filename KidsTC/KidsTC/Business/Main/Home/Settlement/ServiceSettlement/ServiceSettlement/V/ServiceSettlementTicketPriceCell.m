//
//  ServiceSettlementTicketPriceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementTicketPriceCell.h"

@interface ServiceSettlementTicketPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation ServiceSettlementTicketPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceL.textColor = COLOR_PINK;
}



@end
