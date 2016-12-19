//
//  ProductDetailTicketSelectSeatCollectionViewSeatCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewSeatCell.h"
#import "UIButton+Category.h"
#import "Colours.h"
#import "YYKit.h"
#import "NSString+Category.h"

@interface ProductDetailTicketSelectSeatCollectionViewSeatCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLY;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineH;
@end

@implementation ProductDetailTicketSelectSeatCollectionViewSeatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.HlineH.constant = LINE_H;
    self.bgView.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.bgView.layer.borderWidth = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tipLX.constant = CGRectGetWidth(self.frame)*0.5 - CGRectGetHeight(self.frame)*0.25;
    self.tipLY.constant = - CGRectGetHeight(self.frame)*0.25;
    self.tipL.transform = CGAffineTransformMakeRotation(M_PI_4);
}

- (void)setSeat:(ProductDetailTicketSelectSeatSeat *)seat {
    _seat = seat;
    
    self.priceL.text = [NSString stringWithFormat:@"%@",@(seat.price)];
    BOOL showOriginal = seat.orignalPrice>seat.price;
    self.origionalPriceL.text = showOriginal?[NSString stringWithFormat:@"¥%@",@(_seat.orignalPrice)]:nil;
    self.tipL.text = _seat.priceSortName;
    self.tipL.hidden = ![_seat.priceSortName isNotNull];
    self.userInteractionEnabled = seat.maxBuyNum>=1;
    if (self.userInteractionEnabled) {
        if (seat.selected) {
            self.bgView.layer.borderColor = [UIColor colorFromHexString:@"FF8888"].CGColor;
            self.bgView.backgroundColor = [UIColor whiteColor];
            self.seatL.textColor = [UIColor colorFromHexString:@"FF8888"];
            self.priceL.textColor = [UIColor colorFromHexString:@"FF8888"];
            self.origionalPriceL.textColor = [UIColor colorFromHexString:@"999999"];
            self.line.backgroundColor = self.origionalPriceL.textColor;
            self.tipL.backgroundColor = [UIColor colorFromHexString:@"61CEF2"];
        }else{
            self.bgView.layer.borderColor = [UIColor colorFromHexString:@"DEDEDE"].CGColor;
            self.bgView.backgroundColor = [UIColor whiteColor];
            self.seatL.textColor = [UIColor colorFromHexString:@"555555"];
            self.priceL.textColor = [UIColor colorFromHexString:@"555555"];
            self.origionalPriceL.textColor = [UIColor colorFromHexString:@"999999"];
            self.line.backgroundColor = self.origionalPriceL.textColor;
            self.tipL.backgroundColor = [UIColor colorFromHexString:@"61CEF2"];
        }
    }else{
        self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        self.bgView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
        self.seatL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
        self.priceL.textColor = [UIColor colorFromHexString:@"A9A9A9"];
        self.origionalPriceL.textColor = [UIColor colorFromHexString:@"999999"];
        self.line.backgroundColor = self.origionalPriceL.textColor;
        self.tipL.backgroundColor = [UIColor colorFromHexString:@"A9A9A9"];
    }
}

@end
