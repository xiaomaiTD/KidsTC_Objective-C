//
//  OrderBookingViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

@interface OrderBookingViewController : ViewController
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) BOOL mustEdit;
@property (nonatomic, copy) void (^successBlock)();
@end
