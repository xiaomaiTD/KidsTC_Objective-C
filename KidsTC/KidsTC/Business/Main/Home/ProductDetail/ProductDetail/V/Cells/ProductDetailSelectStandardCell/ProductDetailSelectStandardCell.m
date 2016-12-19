//
//  ProductDetailSelectStandardCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSelectStandardCell.h"

@interface ProductDetailSelectStandardCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@end

@implementation ProductDetailSelectStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}
- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.nameL.text = data.serveName;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeSelectStandard value:nil];
    }
}
@end
