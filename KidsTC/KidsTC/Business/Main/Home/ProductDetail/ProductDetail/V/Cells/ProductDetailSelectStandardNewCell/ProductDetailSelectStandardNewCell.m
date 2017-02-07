//
//  ProductDetailSelectStandardNewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSelectStandardNewCell.h"


@interface ProductDetailSelectStandardNewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@end

@implementation ProductDetailSelectStandardNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineH.constant = LINE_H;
    self.dateL.textColor = [UIColor colorFromHexString:@"222222"];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.dateL.text = data.standardName;
}
- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeSelectStandard value:nil];
    }
}

@end
