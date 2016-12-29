//
//  WholesaleOrderListCellBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WholesaleOrderListBtn.h"

@class WholesaleOrderListCellBtnsView;
@protocol WholesaleOrderListCellBtnsViewDelegate <NSObject>
- (void)wholesaleOrderListCellBtnsView:(WholesaleOrderListCellBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end

@interface WholesaleOrderListCellBtnsView : UIView
@property (nonatomic, strong) NSArray<WholesaleOrderListBtn *> *btnsAry;
@property (nonatomic, weak) id<WholesaleOrderListCellBtnsViewDelegate> delegate;
@end
