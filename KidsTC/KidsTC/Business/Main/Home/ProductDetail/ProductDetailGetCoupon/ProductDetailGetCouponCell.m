//
//  ProductDetailGetCouponCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailGetCouponCell.h"
#import "UIImageView+WebCache.h"

@interface ProductDetailGetCouponCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *hasgetImageView;

@end

@implementation ProductDetailGetCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setItem:(ProductDetailGetCouponItem *)item {
    _item = item;
    self.priceL.text = [NSString stringWithFormat:@"%zd",item.couponAmt];
    self.titleL.text = item.couponDesc;
    self.subTitleL.text = item.couponName;
    self.timeL.text = item.time;
    self.hasgetImageView.hidden = !item.isProvider;
    
    NSString *imgName = @"productDetail_coupon_10";
    if (item.couponAmt>=50) {//黄色
        imgName = @"productDetail_coupon_50";
    }else if (item.couponAmt>=100){//粉红
        imgName = @"productDetail_coupon_100";
    }else if (item.couponAmt>=200){//红色
        imgName = @"productDetail_coupon_200";
    }else{
        imgName = @"productDetail_coupon_10";
    }
    self.bgImageView.image = [UIImage imageNamed:imgName];
}

@end
