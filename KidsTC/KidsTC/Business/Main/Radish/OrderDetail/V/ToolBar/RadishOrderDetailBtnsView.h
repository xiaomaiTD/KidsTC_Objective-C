//
//  RadishOrderDetailBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishOrderDetailBtn.h"
@class RadishOrderDetailBtnsView;
@protocol RadishOrderDetailBtnsViewDelegate <NSObject>
- (void)radishOrderDetailBtnsView:(RadishOrderDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end
@interface RadishOrderDetailBtnsView : UIView
@property (nonatomic, strong) NSArray<RadishOrderDetailBtn *> *btnsAry;
@property (nonatomic, weak) id<RadishOrderDetailBtnsViewDelegate> delegate;
@end
