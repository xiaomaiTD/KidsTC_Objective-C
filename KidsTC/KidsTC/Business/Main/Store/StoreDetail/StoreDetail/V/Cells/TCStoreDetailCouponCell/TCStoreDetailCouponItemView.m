//
//  TCStoreDetailCouponItemView.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/16.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCouponItemView.h"

@interface TCStoreDetailCouponItemView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg_get_log;
@end

@implementation TCStoreDetailCouponItemView

- (void)setCoupon:(TCStoreDetailCoupon *)coupon {
    _coupon = coupon;
    NSString *imageName = coupon.isProvider?@"StoreDetail_coupon_get":@"StoreDetail_coupon";
    self.bgImg.image = [UIImage imageNamed:imageName];
    self.bgImg_get_log.hidden = !coupon.isProvider;
    self.titleL.text = coupon.couponName;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailCouponItemView:didClickCoupon:)]) {
        [self.delegate tcStoreDetailCouponItemView:self didClickCoupon:_coupon];
    }
}

@end
