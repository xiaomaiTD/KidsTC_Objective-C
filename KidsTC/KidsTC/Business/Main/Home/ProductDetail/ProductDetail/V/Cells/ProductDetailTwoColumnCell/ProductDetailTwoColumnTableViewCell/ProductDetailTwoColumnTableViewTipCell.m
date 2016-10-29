//
//  ProductDetailTwoColumnTableViewTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnTableViewTipCell.h"

@interface ProductDetailTwoColumnTableViewTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipNumL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTwoColumnTableViewTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    self.tipNumL.text = [NSString stringWithFormat:@"活动咨询(%zd)",count];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailTwoColumnTableViewBaseCell:actionType:value:)]) {
        [self.delegate productDetailTwoColumnTableViewBaseCell:self actionType:ProductDetailTwoColumnTableViewBaseCellActionTypeAddNew value:nil];
    }
}


@end
