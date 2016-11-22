//
//  ServiceSettlementCouponItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSettlementCouponItem : NSObject
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *code;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, assign) CGFloat   couponAmt;
@property (nonatomic, assign) CGFloat   fiftyAmt;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString  *statusName;
@property (nonatomic, strong) NSString  *fetchTime;
@property (nonatomic, strong) NSString  *startTime;
@property (nonatomic, strong) NSString  *endTime;

@property (nonatomic, assign) BOOL selected;
@end
