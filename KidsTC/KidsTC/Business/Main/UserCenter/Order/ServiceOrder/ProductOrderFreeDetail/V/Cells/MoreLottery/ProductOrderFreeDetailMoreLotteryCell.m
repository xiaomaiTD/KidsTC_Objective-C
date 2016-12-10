//
//  ProductOrderFreeDetailMoreLotteryCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailMoreLotteryCell.h"

@interface ProductOrderFreeDetailMoreLotteryCell ()
@property (weak, nonatomic) IBOutlet UIView *moreBGView;

@end

@implementation ProductOrderFreeDetailMoreLotteryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
}

- (void)setLotteryData:(ProductOrderFreeDetailLotteryData *)lotteryData {
    [super setLotteryData:lotteryData];
}

@end
