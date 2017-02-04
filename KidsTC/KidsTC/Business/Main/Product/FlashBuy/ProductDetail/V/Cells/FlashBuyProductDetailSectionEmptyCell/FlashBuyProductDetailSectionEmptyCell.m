//
//  FlashBuyProductDetailSectionEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailSectionEmptyCell.h"

@interface FlashBuyProductDetailSectionEmptyCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation FlashBuyProductDetailSectionEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSectionHeight:(CGFloat)sectionHeight {
    _sectionHeight = sectionHeight;
    self.heightConstraint.constant = sectionHeight;
    [self layoutIfNeeded];
}

@end
