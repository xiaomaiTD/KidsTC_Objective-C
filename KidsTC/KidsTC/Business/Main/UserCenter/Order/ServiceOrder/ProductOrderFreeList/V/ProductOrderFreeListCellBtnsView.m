//
//  ProductOrderFreeListCellBtnsView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListCellBtnsView.h"

@interface ProductOrderFreeListCellBtnsView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@end

@implementation ProductOrderFreeListCellBtnsView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderWidth = 1;
        obj.layer.cornerRadius = 2;
        obj.layer.masksToBounds = YES;
    }];
}

- (void)setBtnsAry:(NSArray<ProductOrderFreeListBtn *> *)btnsAry {
    _btnsAry = btnsAry;
    [_btns enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ProductOrderFreeListBtn *btn;
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
    if ([self.delegate respondsToSelector:@selector(productOrderListFreeCellBtnsView:actionBtn:value:)]) {
        [self.delegate productOrderListFreeCellBtnsView:self actionBtn:sender value:nil];
    }
}

@end
