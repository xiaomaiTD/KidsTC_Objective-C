//
//  TCStoreDetailCouponCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCouponCell.h"

#import "TCStoreDetailCouponItemView.h"

@interface TCStoreDetailCouponCell ()<TCStoreDetailCouponItemViewDelegate>
@property (strong, nonatomic) IBOutletCollection(TCStoreDetailCouponItemView) NSArray *coupons;
@end

@implementation TCStoreDetailCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.coupons enumerateObjectsUsingBlock:^(TCStoreDetailCouponItemView *obj, NSUInteger idx, BOOL *stop) {
        obj.delegate = self;
    }];
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    [self.coupons enumerateObjectsUsingBlock:^(TCStoreDetailCouponItemView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<data.coupons.count) {
            TCStoreDetailCoupon *coupon = data.coupons[idx];
            obj.coupon = coupon;
            obj.hidden = NO;
        }else{
            obj.hidden = YES;
        }
    }];
}

#pragma mark TCStoreDetailCouponItemViewDelegate

- (void)tcStoreDetailCouponItemView:(TCStoreDetailCouponItemView *)view didClickCoupon:(TCStoreDetailCoupon *)coupon {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCoupon value:coupon];
    }
}
@end
