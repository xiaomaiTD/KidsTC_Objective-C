//
//  TCStoreDetailCommentEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCommentEmptyCell.h"

@interface TCStoreDetailCommentEmptyCell ()

@end

@implementation TCStoreDetailCommentEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCommentWrite value:nil];
    }
}

@end
