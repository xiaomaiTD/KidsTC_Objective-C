//
//  RadishOrderDetailBookingCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailBookingCell.h"
#import "NSString+Category.h"

@interface RadishOrderDetailBookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation RadishOrderDetailBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = COLOR_BLUE;
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    NSString *title = data.onlineBespeakButtonText;
    _titleLabel.text = [title isNotNull]?title:@"";
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailBaseCell:actionType:value:)]) {
        if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
            [self.delegate radishOrderDetailBaseCell:self actionType:RadishOrderDetailBaseCellActionTypeBookingMustEdit value:nil];
        }else{
            [self.delegate radishOrderDetailBaseCell:self actionType:RadishOrderDetailBaseCellActionTypeBooking value:nil];
        }
    }
}

@end
