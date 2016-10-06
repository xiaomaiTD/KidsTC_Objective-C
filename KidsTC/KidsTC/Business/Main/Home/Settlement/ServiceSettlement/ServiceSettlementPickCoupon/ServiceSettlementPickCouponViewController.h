//
//  ServiceSettlementPickCouponViewController.h
//  KidsTC
//
//  Created by zhanping on 8/13/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "ServiceSettlementModel.h"
@interface ServiceSettlementPickCouponViewController : ViewController
@property (nonatomic, weak) ServiceSettlementModel *settlementModel;
@property (nonatomic, copy) void (^pickCouponBlock)(ServiceSettlementCouponItem *coupon);
@end
