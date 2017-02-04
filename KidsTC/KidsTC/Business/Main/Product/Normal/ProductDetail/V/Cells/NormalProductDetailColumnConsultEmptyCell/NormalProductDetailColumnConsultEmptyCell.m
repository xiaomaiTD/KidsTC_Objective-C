//
//  NormalProductDetailColumnConsultEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailColumnConsultEmptyCell.h"

@interface NormalProductDetailColumnConsultEmptyCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation NormalProductDetailColumnConsultEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.backgroundColor = PRODUCT_DETAIL_BLUE;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeAddNewConsult value:nil];
    }
}


@end
