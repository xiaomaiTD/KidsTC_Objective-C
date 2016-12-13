//
//  ProductOrderNormalDetailContactCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailContactCell.h"
#import "Colours.h"

@interface ProductOrderNormalDetailContactCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ProductOrderNormalDetailContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorFromHexString:@"DDDDDD"].CGColor;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBaseCell:actionType:value:)]) {
        [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeContact value:self.data.supplierPhones];
    }
}

@end
