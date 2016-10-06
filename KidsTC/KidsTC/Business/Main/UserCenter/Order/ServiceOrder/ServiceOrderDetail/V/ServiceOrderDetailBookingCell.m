//
//  ServiceOrderDetailBookingCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceOrderDetailBookingCell.h"
#import "NSString+Category.h"

@interface ServiceOrderDetailBookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation ServiceOrderDetailBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.textColor = COLOR_BLUE;
    self.HLineConstraintHeight.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ServiceOrderDetailData *)data {
    [super setData:data];
    
    NSString *title = data.onlineBespeakButtonText;
    _titleLabel.text = [title isNotNull]?title:@"";
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceOrderDetailBaseCell:actionType:)]) {
        if (self.data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
            [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeBookingMustEdit];
        }else{
            [self.delegate serviceOrderDetailBaseCell:self actionType:ServiceOrderDetailBaseCellActionTypeBooking];
        }
    }
}

@end
