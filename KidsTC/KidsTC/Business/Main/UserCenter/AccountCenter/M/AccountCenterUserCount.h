//
//  AccountCenterUserCount.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCenterUserCount : NSObject
@property (nonatomic, assign) NSUInteger appointment_wait_arrive;
@property (nonatomic, assign) NSUInteger order_wait_pay;
@property (nonatomic, assign) NSUInteger order_wait_use;
@property (nonatomic, assign) NSUInteger order_wait_evaluate;
@property (nonatomic, assign) NSUInteger order_wait_received_count;
@property (nonatomic, assign) NSUInteger order_wait_refund_count;
@property (nonatomic, assign) NSUInteger unReadMsgCount;
@property (nonatomic, assign) NSUInteger score_num;
@property (nonatomic, assign) NSUInteger userRadishNum;
@property (nonatomic, assign) NSUInteger userGrowthValue;
@property (nonatomic, assign) BOOL userHasNewCoupon;
@property (nonatomic, assign) NSUInteger product_collect_num;
@property (nonatomic, assign) NSUInteger store_collect_num;
@property (nonatomic, assign) NSUInteger like_content_num;
@property (nonatomic, assign) NSUInteger like_author_num;
@property (nonatomic, assign) NSUInteger coupon_num;
@property (nonatomic, assign) NSUInteger tcECordMoney;
@property (nonatomic, assign) NSUInteger myResidual;
@property (nonatomic, assign) BOOL userHasNewFlashProduct;
@property (nonatomic, assign) BOOL userHasNewAppointmentOrder;
@end
