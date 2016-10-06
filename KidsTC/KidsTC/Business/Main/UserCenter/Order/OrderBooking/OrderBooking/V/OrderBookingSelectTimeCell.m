//
//  OrderBookingSelectTimeCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingSelectTimeCell.h"
#import "NSString+Category.h"

@interface OrderBookingSelectTimeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation OrderBookingSelectTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(OrderBookingData *)data {
    [super setData:data];
    
    NSString *timeTitle = @"";
    
    OrderBookingTimeShowModel *timeShowModel = data.currentTimeShowModel;
    if (timeShowModel) {
        NSString *dayStr = timeShowModel.dayStr;
        NSString *weakStr = timeShowModel.weakStr;
        NSString *timeStr = timeShowModel.timesAry[timeShowModel.selectIndex];
        if ([dayStr isNotNull] && [weakStr isNotNull] && [timeStr isNotNull]) {
            timeTitle = [NSString stringWithFormat:@"%@（%@） %@",dayStr,weakStr,timeStr];
        }
    }
    _timeLabel.text = timeTitle;
    
    if (self.mustEdit) {
        self.userInteractionEnabled = YES;
    }else{
        BOOL canBespeak = data.bespeakStatus == OrderBookingBespeakStatusCanBespeak;
        self.userInteractionEnabled = canBespeak;
    }
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(orderBookingBaseCell:actionType:value:)]) {
        [self.delegate orderBookingBaseCell:self actionType:OrderBookingBaseCellActionTypeSelectTime value:nil];
    }
}

@end
