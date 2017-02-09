//
//  TCStoreDetailCouponCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCouponCell.h"

@interface TCStoreDetailCouponCell ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *coupons;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@end

@implementation TCStoreDetailCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btns enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.tag = idx;
    }];
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    
    [self.coupons enumerateObjectsUsingBlock:^(UIView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<data.coupons.count && idx<self.labels.count) {
            NSString *str = data.coupons[idx];
            UILabel *label = self.labels[idx];
            label.text = str;
            obj.hidden = NO;
        }else{
            obj.hidden = YES;
        }
    }];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCoupon value:@(sender.tag)];
    }
}
@end
