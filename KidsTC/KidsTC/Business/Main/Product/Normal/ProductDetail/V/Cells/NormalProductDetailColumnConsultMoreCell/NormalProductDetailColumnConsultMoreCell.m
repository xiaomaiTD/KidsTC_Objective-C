//
//  NormalProductDetailColumnConsultMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailColumnConsultMoreCell.h"

@interface NormalProductDetailColumnConsultMoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end

@implementation NormalProductDetailColumnConsultMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreBtn.layer.borderWidth = LINE_H;
    self.moreBtn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    [self.moreBtn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeMoreConsult value:nil];
    }
}


@end
