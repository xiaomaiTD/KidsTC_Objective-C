//
//  FlashBuyProductDetailCommentEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailCommentEmptyCell.h"

@interface FlashBuyProductDetailCommentEmptyCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewH;

@end

@implementation FlashBuyProductDetailCommentEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgViewH.constant = SCREEN_HEIGHT;
    [self layoutIfNeeded];
    
}

@end
