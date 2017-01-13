//
//  ActivityProductCoupon.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ActivityProductCoupon : NSObject
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponDesc;
@property (nonatomic, strong) NSString *couponAmt;
@property (nonatomic, strong) NSString *fiftyAmt;
@property (nonatomic, strong) NSString *isSmsCode;
@property (nonatomic, strong) NSString *isPicCode;
@property (nonatomic, strong) NSString *maxNum;
@property (nonatomic, strong) NSString *totalNum;
@property (nonatomic, strong) NSString *isCanReceive;
@property (nonatomic, strong) NSString *hadReceivedNum;
@property (nonatomic, strong) NSString *couponPic;
@end
