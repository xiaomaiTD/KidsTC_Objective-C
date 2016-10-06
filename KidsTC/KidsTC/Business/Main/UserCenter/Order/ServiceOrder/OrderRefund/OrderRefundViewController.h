//
//  OrderRefundViewController.h
//  KidsTC
//
//  Created by Altair on 11/28/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"

@class OrderRefundViewController;

@protocol OrderRefundViewControllerDelegate <NSObject>

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier;

@end

@interface OrderRefundViewController : ViewController

@property (nonatomic, assign) id<OrderRefundViewControllerDelegate> delegate;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
