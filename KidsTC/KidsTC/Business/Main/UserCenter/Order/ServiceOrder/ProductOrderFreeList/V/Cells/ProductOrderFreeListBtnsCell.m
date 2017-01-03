//
//  ProductOrderFreeListBtnsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListBtnsCell.h"
#import "ProductOrderFreeListCellBtnsView.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

@interface ProductOrderFreeListBtnsCell ()<ProductOrderFreeListCellBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet ProductOrderFreeListCellBtnsView *btnsView;
@end

@implementation ProductOrderFreeListBtnsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnsView.delegate = self;
}

- (void)setItem:(ProductOrderFreeListItem *)item {
    [super setItem:item];
    self.btnsView.btnsAry = self.item.btns;
}

#pragma mark - ProductOrderFreeListCellBtnsViewDelegate

- (void)productOrderListFreeCellBtnsView:(ProductOrderFreeListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeListBaseCell:self actionType:(ProductOrderFreeListBaseCellActionType)btn.tag value:self.item];
        [self buryPoint:btn.tag];
    }
}

- (void)buryPoint:(NSInteger)type {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *orderId = self.item.orderNo;
    if ([orderId isNotNull]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [params setObject:@(type) forKey:@"optionType"];
    [BuryPointManager trackEvent:@"event_click_order_option" actionId:21615 params:params];
}
@end
