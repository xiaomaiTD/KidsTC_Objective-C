//
//  RadishProductDetailDateCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailDateCell.h"


@interface RadishProductDetailDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@end

@implementation RadishProductDetailDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineH.constant = LINE_H;
    self.dateL.textColor = [UIColor colorFromHexString:@"222222"];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    [self layoutIfNeeded];
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    self.dateL.text = data.time.desc;
}
- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeShowDate value:self.data.time.times];
    }
}

@end
