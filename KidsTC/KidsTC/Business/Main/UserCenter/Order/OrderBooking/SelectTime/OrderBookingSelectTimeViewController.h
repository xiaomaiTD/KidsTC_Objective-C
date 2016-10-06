//
//  OrderBookingSelectTimeViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "OrderBookingModel.h"

@interface OrderBookingSelectTimeViewController : ViewController
@property (nonatomic, strong) OrderBookingData *data;
@property (nonatomic, copy) void (^makeSureBlock)(OrderBookingTimeShowModel *model);
@end
