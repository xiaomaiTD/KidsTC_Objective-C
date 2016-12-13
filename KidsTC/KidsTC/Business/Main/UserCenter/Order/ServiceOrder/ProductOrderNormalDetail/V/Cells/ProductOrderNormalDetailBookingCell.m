//
//  ProductOrderNormalDetailBookingCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailBookingCell.h"
#import "NSString+Category.h"

@interface ProductOrderNormalDetailBookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation ProductOrderNormalDetailBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = COLOR_BLUE;
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    NSString *title = data.onlineBespeakButtonText;
    _titleLabel.text = [title isNotNull]?title:@"";
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBaseCell:actionType:value:)]) {
        if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
            [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeBookingMustEdit value:nil];
        }else{
            [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeBooking value:nil];
        }
    }
}

@end
