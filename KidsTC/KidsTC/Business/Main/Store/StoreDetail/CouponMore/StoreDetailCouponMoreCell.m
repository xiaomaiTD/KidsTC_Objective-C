//
//  StoreDetailCouponMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "StoreDetailCouponMoreCell.h"

#import "UIImageView+WebCache.h"

@interface StoreDetailCouponMoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *hasgetImageView;

@end

@implementation StoreDetailCouponMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setCoupon:(TCStoreDetailCoupon *)coupon {
    _coupon = coupon;
    self.priceL.text = [NSString stringWithFormat:@"%zd",coupon.couponAmt];
    self.titleL.text = coupon.couponDesc;
    self.subTitleL.text = coupon.couponName;
    self.timeL.text = coupon.time;
    self.hasgetImageView.hidden = !coupon.isProvider;
    
    NSString *imgName = @"productDetail_coupon_10";
    if (coupon.couponAmt>=50) {//黄色
        imgName = @"productDetail_coupon_50";
    }else if (coupon.couponAmt>=100){//粉红
        imgName = @"productDetail_coupon_100";
    }else if (coupon.couponAmt>=200){//红色
        imgName = @"productDetail_coupon_200";
    }else{
        imgName = @"productDetail_coupon_10";
    }
    self.bgImageView.image = [UIImage imageNamed:imgName];
}


@end
