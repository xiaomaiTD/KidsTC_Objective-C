//
//  ProductOrderFreeDetailBtnsView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailBtnsView.h"

@interface ProductOrderFreeDetailBtnsView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@end

@implementation ProductOrderFreeDetailBtnsView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderWidth = 1;
        obj.layer.cornerRadius = 2;
        obj.layer.masksToBounds = YES;
    }];
}

- (void)setBtnsAry:(NSArray<ProductOrderFreeDetailBtn *> *)btnsAry {
    _btnsAry = btnsAry;
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ProductOrderFreeDetailBtn *btn;
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
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailBtnsView:actionBtn:value:)]) {
        [self.delegate productOrderFreeDetailBtnsView:self actionBtn:sender value:nil];
    }
}
@end
