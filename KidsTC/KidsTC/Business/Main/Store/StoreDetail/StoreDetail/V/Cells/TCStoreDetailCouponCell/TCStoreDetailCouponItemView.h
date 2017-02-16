//
//  TCStoreDetailCouponItemView.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCStoreDetailCoupon.h"
@class TCStoreDetailCouponItemView;
@protocol TCStoreDetailCouponItemViewDelegate <NSObject>
- (void)tcStoreDetailCouponItemView:(TCStoreDetailCouponItemView *)view didClickCoupon:(TCStoreDetailCoupon *)coupon;
@end
@interface TCStoreDetailCouponItemView : UIView
@property (nonatomic,strong) TCStoreDetailCoupon *coupon;
@property (nonatomic,  weak) id<TCStoreDetailCouponItemViewDelegate> delegate;
@end
