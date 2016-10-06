//
//  FlashServiceOrderDetailBookingCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FlashServiceOrderDetailBookingCell.h"
#import "NSString+Category.h"

@interface FlashServiceOrderDetailBookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation FlashServiceOrderDetailBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = COLOR_BLUE;
    self.HLineConstraintHeight.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(FlashServiceOrderDetailData *)data {
    [super setData:data];
    NSString *title = data.onlineBespeakButtonText;
    _titleLabel.text = [title isNotNull]?title:@"";
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailBaseCell:actionType:)]) {
        if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
            [self.delegate flashServiceOrderDetailBaseCell:self actionType:FlashServiceOrderDetailBaseCellActionTypeBookingMustEdit];
        }else{
            [self.delegate flashServiceOrderDetailBaseCell:self actionType:FlashServiceOrderDetailBaseCellActionTypeBooking];
        }
    }
}
@end
