//
//  FlashBuyProductDetailStoreEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailStoreEmptyCell.h"

@interface FlashBuyProductDetailStoreEmptyCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewH;

@end

@implementation FlashBuyProductDetailStoreEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgViewH.constant = SCREEN_HEIGHT;
    [self layoutIfNeeded];
}

@end
