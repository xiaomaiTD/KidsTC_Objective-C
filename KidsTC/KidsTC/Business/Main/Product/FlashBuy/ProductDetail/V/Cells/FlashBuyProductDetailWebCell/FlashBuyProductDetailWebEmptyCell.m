//
//  FlashBuyProductDetailWebEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailWebEmptyCell.h"

@interface FlashBuyProductDetailWebEmptyCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewH;

@end

@implementation FlashBuyProductDetailWebEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgViewH.constant = SCREEN_HEIGHT;
    [self layoutIfNeeded];
}

@end
