//
//  TCStoreDetailSectionEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailSectionEmptyCell.h"

@interface TCStoreDetailSectionEmptyCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation TCStoreDetailSectionEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSectionHeight:(CGFloat)sectionHeight {
    _sectionHeight = sectionHeight;
    self.heightConstraint.constant = sectionHeight;
    [self layoutIfNeeded];
}

@end
