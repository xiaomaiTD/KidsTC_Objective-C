//
//  ProductDetailCouponCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCouponCell.h"

@interface ProductDetailCouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@end

@implementation ProductDetailCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    _labels = [NSMutableArray array];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    [self layoutIfNeeded];
    
    if (_labels.count>0) {
        [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_labels removeAllObjects];
    }
    
    CGFloat margin = 15;
    
    __block CGRect lastFrame = self.tipL.frame;
    CGFloat label_h = 21;
    CGFloat label_y = (CGRectGetHeight(self.bounds) - label_h) * 0.5;
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat maxX = CGRectGetMinX(self.arrowImgView.frame) - margin;
    [data.coupons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat label_w = [obj sizeWithAttributes:@{NSFontAttributeName:font}].width + 10;
        CGFloat label_x = CGRectGetMaxX(lastFrame) + margin;
        CGRect frame = CGRectMake(label_x, label_y, label_w, label_h);
        if (CGRectGetMaxX(frame)<maxX) {
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.text = obj;
            label.textColor = [UIColor whiteColor];
            label.font = font;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = COLOR_PINK;
            label.layer.cornerRadius = 2;
            label.layer.masksToBounds = YES;
            [self addSubview:label];
            [_labels addObject:label];
            lastFrame = frame;
        }
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeCoupon value:@(self.data.canProvideCoupon)];
    }
}

@end
