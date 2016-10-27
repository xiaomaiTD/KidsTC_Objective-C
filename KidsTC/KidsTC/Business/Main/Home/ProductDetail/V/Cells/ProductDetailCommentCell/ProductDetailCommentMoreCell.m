//
//  ProductDetailCommentMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCommentMoreCell.h"

@interface ProductDetailCommentMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailCommentMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btn.layer.borderWidth = LINE_H;
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeMoreComment value:self.data];
    }
}


@end
