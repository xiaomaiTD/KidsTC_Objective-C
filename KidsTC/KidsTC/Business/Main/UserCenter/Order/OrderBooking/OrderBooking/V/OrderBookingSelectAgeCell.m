//
//  OrderBookingSelectAgeCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingSelectAgeCell.h"
#import "NSString+Category.h"

@interface OrderBookingSelectAgeCell()
@property (weak, nonatomic) IBOutlet UILabel *ageTitle;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation OrderBookingSelectAgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(OrderBookingData *)data {
    [super setData:data];
    NSString *ageTitle = [NSString stringWithFormat:@"%zd岁",data.userBespeakInfo.babyAge];
    self.ageTitle.text = ageTitle;
    
    if (self.mustEdit) {
        self.userInteractionEnabled = YES;
        self.arrowImageView.hidden = NO;
    }else{
        BOOL canBespeak = (data.bespeakStatus == OrderBookingBespeakStatusCanBespeak);
        self.userInteractionEnabled = canBespeak;
        self.arrowImageView.hidden = !canBespeak;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(orderBookingBaseCell:actionType:value:)]) {
        [self.delegate orderBookingBaseCell:self actionType:OrderBookingBaseCellActionTypeSelectAge value:nil];
    }
}

@end
