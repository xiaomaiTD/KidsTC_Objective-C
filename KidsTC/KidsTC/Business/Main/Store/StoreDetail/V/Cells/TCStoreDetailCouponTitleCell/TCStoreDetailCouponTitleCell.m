//
//  TCStoreDetailCouponTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCouponTitleCell.h"

@interface TCStoreDetailCouponTitleCell ()
@property (weak, nonatomic) IBOutlet UIView *iconTextBGView;
@property (weak, nonatomic) IBOutlet UILabel *iconTextL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation TCStoreDetailCouponTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconTextBGView.layer.borderColor = [UIColor colorFromHexString:@"FC981E"].CGColor;
    self.iconTextBGView.layer.borderWidth = 1;
    self.HLineH.constant = LINE_H;
}


@end
