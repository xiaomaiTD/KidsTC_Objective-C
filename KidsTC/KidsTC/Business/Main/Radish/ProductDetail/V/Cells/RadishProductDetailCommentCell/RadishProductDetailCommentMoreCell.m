//
//  RadishProductDetailCommentMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailCommentMoreCell.h"

@interface RadishProductDetailCommentMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RadishProductDetailCommentMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btn.layer.borderWidth = LINE_H;
    
}

- (void)setData:(RadishProductDetailData *)data {
    [super setData:data];
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailBaseCell:actionType:value:)]) {
        [self.delegate radishProductDetailBaseCell:self actionType:RadishProductDetailBaseCellActionTypeMoreComment value:self.data];
    }
}


@end
