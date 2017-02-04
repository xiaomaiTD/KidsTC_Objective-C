//
//  FlashBuyProductDetailCommentMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailCommentMoreCell.h"

@interface FlashBuyProductDetailCommentMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation FlashBuyProductDetailCommentMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btn.layer.borderWidth = LINE_H;
    
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailBaseCell:actionType:vlaue:)]) {
        [self.delegate flashBuyProductDetailBaseCell:self actionType:FlashBuyProductDetailBaseCellActionTypeMoreComment vlaue:nil];
    }
}


@end
