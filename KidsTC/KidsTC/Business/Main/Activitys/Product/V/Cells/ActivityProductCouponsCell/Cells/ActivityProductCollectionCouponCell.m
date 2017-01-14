//
//  ActivityProductCollectionCouponCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductCollectionCouponCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
@interface ActivityProductCollectionCouponCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end

@implementation ActivityProductCollectionCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCoupon:(ActivityProductCoupon *)coupon {
    _coupon = coupon;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:coupon.couponPic] placeholderImage:PLACEHOLDERIMAGE_BIG];
}

@end
