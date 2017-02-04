//
//  FlashBuyProductDetailBuyNoticeTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailBuyNoticeTitleCell.h"

@interface FlashBuyProductDetailBuyNoticeTitleCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation FlashBuyProductDetailBuyNoticeTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}



@end
