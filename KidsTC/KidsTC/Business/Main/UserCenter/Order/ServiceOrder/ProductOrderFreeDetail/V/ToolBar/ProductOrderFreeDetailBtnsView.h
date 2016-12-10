//
//  ProductOrderFreeDetailBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailBtn.h"
@class ProductOrderFreeDetailBtnsView;
@protocol ProductOrderFreeDetailBtnsViewDelegate <NSObject>
- (void)productOrderFreeDetailBtnsView:(ProductOrderFreeDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end
@interface ProductOrderFreeDetailBtnsView : UIView
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailBtn *> *btnsAry;
@property (nonatomic, weak) id<ProductOrderFreeDetailBtnsViewDelegate> delegate;
@end
