//
//  ProductOrderNormalDetailBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderNormalDetailBtn.h"
@class ProductOrderNormalDetailBtnsView;
@protocol ProductOrderNormalDetailBtnsViewDelegate <NSObject>
- (void)productOrderNormalDetailBtnsView:(ProductOrderNormalDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end
@interface ProductOrderNormalDetailBtnsView : UIView
@property (nonatomic, strong) NSArray<ProductOrderNormalDetailBtn *> *btnsAry;
@property (nonatomic, weak) id<ProductOrderNormalDetailBtnsViewDelegate> delegate;
@end
