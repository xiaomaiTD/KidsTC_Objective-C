//
//  ProductOrderFreeListCellBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderFreeListBtn.h"

@class ProductOrderFreeListCellBtnsView;
@protocol ProductOrderFreeListCellBtnsViewDelegate <NSObject>
- (void)productOrderListFreeCellBtnsView:(ProductOrderFreeListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end

@interface ProductOrderFreeListCellBtnsView : UIView
@property (nonatomic, strong) NSArray<ProductOrderFreeListBtn *> *btnsAry;
@property (nonatomic, weak) id<ProductOrderFreeListCellBtnsViewDelegate> delegate;
@end
