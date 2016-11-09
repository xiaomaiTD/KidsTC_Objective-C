//
//  AccountCenterUserCount.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCenterUserCount : NSObject
@property (nonatomic, assign) NSInteger appointment_wait_arrive;
@property (nonatomic, assign) NSUInteger order_wait_pay;
@property (nonatomic, assign) NSUInteger order_wait_use;
@property (nonatomic, assign) NSUInteger order_wait_evaluate;
@property (nonatomic, assign) NSInteger unReadMsgCount;
@property (nonatomic, assign) NSInteger score_num;
@property (nonatomic, assign) NSInteger userRadishNum;
@property (nonatomic, assign) NSInteger userGrowthValue;
@property (nonatomic, assign) BOOL userHasNewCoupon;
@end
