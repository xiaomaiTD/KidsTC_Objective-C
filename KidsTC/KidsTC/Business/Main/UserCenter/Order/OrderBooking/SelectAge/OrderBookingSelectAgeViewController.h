//
//  OrderBookingSelectAgeViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

@interface OrderBookingSelectAgeViewController : ViewController
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, copy) void(^makeSureBlock)(NSInteger age);
@end
