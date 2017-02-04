//
//  NormalProductDetailCommentMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailCommentMoreCell.h"

@interface NormalProductDetailCommentMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation NormalProductDetailCommentMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btn.layer.borderWidth = LINE_H;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeMoreComment value:self.data];
    }
}


@end
