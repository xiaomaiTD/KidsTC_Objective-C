//
//  ProductOrderListBtnsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductOrderListBtnsCell.h"
#import "ProductOrderListCellBtnsView.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

@interface ProductOrderListBtnsCell ()<ProductOrderListCellBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet ProductOrderListCellBtnsView *btnsView;
@end

@implementation ProductOrderListBtnsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnsView.delegate = self;
}

- (void)setItem:(ProductOrderListItem *)item {
    [super setItem:item];
    self.btnsView.btnsAry = self.item.btns;
}

#pragma mark - ProductOrderListCellBtnsViewDelegate

- (void)productOrderListCellBtnsView:(ProductOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderListBaseCell:actionType:value:)]) {
        [self.delegate productOrderListBaseCell:self actionType:(ProductOrderListBaseCellActionType)btn.tag value:self.item];
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
