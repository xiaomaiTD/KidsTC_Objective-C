//
//  ProductOrderNormalDetailBtnsView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailBtnsView.h"

@interface ProductOrderNormalDetailBtnsView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@end

@implementation ProductOrderNormalDetailBtnsView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderWidth = 1;
        obj.layer.cornerRadius = 2;
        obj.layer.masksToBounds = YES;
    }];
}

- (void)setBtnsAry:(NSArray<ProductOrderNormalDetailBtn *> *)btnsAry {
    _btnsAry = btnsAry;
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ProductOrderNormalDetailBtn *btn;
        if (idx<btnsAry.count) {
            btn = btnsAry[idx];
        }
        if (btn) {
            obj.hidden = NO;
            obj.tag = btn.type;
            [obj setTitle:btn.title forState:UIControlStateNormal];
            [obj setTitleColor:btn.titleColor forState:UIControlStateNormal];
            obj.layer.borderColor = btn.borderColor.CGColor;
        }else{
            obj.hidden = YES;
        }
    }];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBtnsView:actionBtn:value:)]) {
        [self.delegate productOrderNormalDetailBtnsView:self actionBtn:sender value:nil];
    }
}

@end
