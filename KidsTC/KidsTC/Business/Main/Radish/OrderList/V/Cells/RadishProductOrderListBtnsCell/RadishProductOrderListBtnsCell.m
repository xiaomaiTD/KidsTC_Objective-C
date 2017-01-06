//
//  RadishProductOrderListBtnsCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListBtnsCell.h"
#import "RadishProductOrderListCellBtnsView.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

@interface RadishProductOrderListBtnsCell ()<RadishProductOrderListCellBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet RadishProductOrderListCellBtnsView *btnsView;
@end

@implementation RadishProductOrderListBtnsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnsView.delegate = self;
}

- (void)setItem:(RadishProductOrderListItem *)item {
    [super setItem:item];
    self.btnsView.btnsAry = self.item.btns;
}

#pragma mark - RadishProductOrderListCellBtnsViewDelegate

- (void)RadishProductOrderListCellBtnsView:(RadishProductOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductOrderListBaseCell:actionType:value:)]) {
        [self.delegate radishProductOrderListBaseCell:self actionType:(RadishProductOrderListBaseCellActionType)btn.tag value:self.item];
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
