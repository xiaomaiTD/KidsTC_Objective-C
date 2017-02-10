//
//  StoreDetailCouponMoreViewController.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "TCStoreDetailCoupon.h"

@class StoreDetailCouponMoreViewController;
@protocol StoreDetailCouponMoreViewControllerDelegate <NSObject>
- (void)couponStatusHasChangeStoreDetailCouponMoreViewController:(StoreDetailCouponMoreViewController *)controller;
@end

@interface StoreDetailCouponMoreViewController : ViewController
@property (nonatomic, strong) NSArray<TCStoreDetailCoupon *> *coupons;
@property (nonatomic, weak) id<StoreDetailCouponMoreViewControllerDelegate> delegate;
@end
