//
//  AccountCenterUserCount.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCenterUserCount : NSObject
@property (nonatomic, strong) NSString *appointment_wait_arrive;
@property (nonatomic, strong) NSString *order_wait_pay;
@property (nonatomic, strong) NSString *order_wait_use;
@property (nonatomic, strong) NSString *order_wait_evaluate;
@property (nonatomic, strong) NSString *unReadMsgCount;
@property (nonatomic, strong) NSString *score_num;
@property (nonatomic, strong) NSString *userRadishNum;
@property (nonatomic, strong) NSString *userGrowthValue;
@property (nonatomic, assign) BOOL userHasNewCoupon;
@end
