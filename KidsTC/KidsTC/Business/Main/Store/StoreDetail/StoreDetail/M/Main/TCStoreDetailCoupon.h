//
//  TCStoreDetailCoupon.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TCStoreDetailCoupon : NSObject
@property (nonatomic, strong) NSString *batchNo;
@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponDesc;
@property (nonatomic, assign) NSInteger couponAmt;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger fiftyAmt;
@property (nonatomic, assign) BOOL isProvider;
@property (nonatomic, assign) BOOL canRedirect;
@end
