//
//  RadishProductOrderListCellBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductOrderListBtn.h"

@class RadishProductOrderListCellBtnsView;
@protocol RadishProductOrderListCellBtnsViewDelegate <NSObject>
- (void)radishProductOrderListCellBtnsView:(RadishProductOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end

@interface RadishProductOrderListCellBtnsView : UIView
@property (nonatomic, strong) NSArray<RadishProductOrderListBtn *> *btnsAry;
@property (nonatomic, weak) id<RadishProductOrderListCellBtnsViewDelegate> delegate;
@end
