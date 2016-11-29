//
//  CouponListItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponListItem : NSObject
@property (nonatomic, strong) NSString *batchSysNo;
@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponCode;
@property (nonatomic, strong) NSString *couponDesc;
@property (nonatomic, strong) NSString *couponAmt;
@property (nonatomic, strong) NSString *fiftyAmt;
@property (nonatomic, strong) NSString *fiftyDesc;
@property (nonatomic, assign) UseCouponStatus useCouponStatus;
@property (nonatomic, strong) NSString *useCouponStatusDesc;
@property (nonatomic, strong) NSString *receiveTime;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, assign) BOOL isExpiring;
@property (nonatomic, strong) NSString *validTimeDesc;
@property (nonatomic, assign) BOOL isLink;

//selfDefine
@property (nonatomic, assign) BOOL isTipOpen;
@end
