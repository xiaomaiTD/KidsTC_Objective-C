//
//  ProductOrderFreeDetailMoreLotteryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailMoreLotteryCell.h"
#import "Colours.h"

@interface ProductOrderFreeDetailMoreLotteryCell ()
@property (weak, nonatomic) IBOutlet UIView *moreBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductOrderFreeDetailMoreLotteryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.moreBGView.layer.cornerRadius = 4;
    self.moreBGView.layer.masksToBounds = YES;
    self.moreBGView.layer.borderColor = [UIColor colorFromHexString:@"DDDDDD"].CGColor;
    self.moreBGView.layer.borderWidth = 1;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.moreBGView addGestureRecognizer:tapGR];
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailInfoBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeDetailInfoBaseCell:self actionType:ProductOrderFreeDetailInfoBaseCellActionTypeMoreLottery value:@(NO)];
    }
}

@end
