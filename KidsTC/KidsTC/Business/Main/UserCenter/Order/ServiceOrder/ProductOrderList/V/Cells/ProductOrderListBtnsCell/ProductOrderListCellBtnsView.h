//
//  ProductOrderListCellBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderListBtn.h"

@class ProductOrderListCellBtnsView;
@protocol ProductOrderListCellBtnsViewDelegate <NSObject>
- (void)productOrderListCellBtnsView:(ProductOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end

@interface ProductOrderListCellBtnsView : UIView
@property (nonatomic, strong) NSArray<ProductOrderListBtn *> *btnsAry;
@property (nonatomic, weak) id<ProductOrderListCellBtnsViewDelegate> delegate;
@end
