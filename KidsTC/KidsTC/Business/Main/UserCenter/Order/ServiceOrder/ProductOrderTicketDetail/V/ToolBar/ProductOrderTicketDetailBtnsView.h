//
//  ProductOrderTicketDetailBtnsView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductOrderTicketDetailBtn.h"
@class ProductOrderTicketDetailBtnsView;
@protocol ProductOrderTicketDetailBtnsViewDelegate <NSObject>
- (void)productOrderTicketDetailBtnsView:(ProductOrderTicketDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value;
@end
@interface ProductOrderTicketDetailBtnsView : UIView
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailBtn *> *btnsAry;
@property (nonatomic, weak) id<ProductOrderTicketDetailBtnsViewDelegate> delegate;
@end
