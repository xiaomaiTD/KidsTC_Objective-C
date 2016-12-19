//
//  ProductOrderListViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
@interface ProductOrderListViewController : ViewController
@property (nonatomic, assign) ProductOrderListType type;
@property (nonatomic, assign) ProductOrderListOrderType orderType;
- (instancetype)initWithType:(ProductOrderListType)type;
- (void)insetOrderType:(ProductOrderListOrderType)orderType;
@end
