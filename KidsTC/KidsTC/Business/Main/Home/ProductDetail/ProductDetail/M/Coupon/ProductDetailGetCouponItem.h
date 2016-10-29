//
//  ProductDetailGetCouponItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailGetCouponItem : NSObject
@property (nonatomic, strong) NSString *batchNo;
@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponDesc;
@property (nonatomic, assign) NSInteger couponAmt;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger fiftyAmt;
@property (nonatomic, assign) BOOL isProvider;
@property (nonatomic, assign) BOOL canRedirect;
@end
