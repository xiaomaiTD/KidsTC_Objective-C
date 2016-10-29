//
//  ProductDetailTwoColumnTableViewEmptyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnTableViewEmptyCell.h"

@interface ProductDetailTwoColumnTableViewEmptyCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTwoColumnTableViewEmptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.layer.cornerRadius = 4;
    self.btn.layer.masksToBounds = YES;
    self.btn.backgroundColor = PRODUCT_DETAIL_BLUE;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailTwoColumnTableViewBaseCell:actionType:value:)]) {
        [self.delegate productDetailTwoColumnTableViewBaseCell:self actionType:ProductDetailTwoColumnTableViewBaseCellActionTypeAddNew value:nil];
    }
}


@end
