//
//  RadishOrderDetailBookingFailureCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailBookingFailureCell.h"

@interface RadishOrderDetailBookingFailureCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation RadishOrderDetailBookingFailureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _HLineConstraintHeight.constant = LINE_H;
    _titleLabel.attributedText = self.attTitle;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
}

- (NSAttributedString *)attTitle {
    static NSMutableAttributedString *attStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        attStr = [[NSMutableAttributedString alloc] init];
        NSAttributedString *one = [[NSAttributedString alloc] initWithString:@"您上一次的预约失败，点击"];
        NSAttributedString *two = [[NSMutableAttributedString alloc] initWithString:@"查看详情" attributes:@{NSUnderlineStyleAttributeName:@(YES)}];
        [attStr appendAttributedString:one];
        [attStr appendAttributedString:two];
        NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSForegroundColorAttributeName:COLOR_PINK};
        [attStr addAttributes:att range:NSMakeRange(0, attStr.length)];
    });
    return attStr;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailBaseCell:actionType:value:)]) {
        [self.delegate radishOrderDetailBaseCell:self actionType:RadishOrderDetailBaseCellActionTypeBooking value:nil];
    }
}

@end
