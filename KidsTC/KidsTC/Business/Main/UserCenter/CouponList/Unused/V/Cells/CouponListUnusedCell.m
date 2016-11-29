//
//  CouponListUnusedCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedCell.h"
#import "Colours.h"

@interface CouponListUnusedCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@property (weak, nonatomic) IBOutlet UIImageView *expiredIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation CouponListUnusedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    self.useBtn.layer.borderWidth = 1;
    self.useBtn.layer.cornerRadius = CGRectGetHeight(self.useBtn.frame) * 0.5;
    self.useBtn.layer.masksToBounds = YES;
    self.useBtn.tag = CouponListUnusedCellActionTypeUseCoupon;
    self.detailBtn.tag = CouponListUnusedCellActionTypeOpearteTip;
}
- (IBAction)detailAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.item.isTipOpen = sender.selected;
    if ([self.delegate respondsToSelector:@selector(couponListUnusedCell:actionType:value:)]) {
        [self.delegate couponListUnusedCell:self actionType:sender.tag value:nil];
    }
}

- (IBAction)useAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(couponListUnusedCell:actionType:value:)]) {
        [self.delegate couponListUnusedCell:self actionType:sender.tag value:self.item.couponCode];
    }
}

- (void)setItem:(CouponListItem *)item {
    _item = item;
    
    self.expiredIcon.hidden = !_item.isExpiring;
    self.nameL.text = _item.couponName;
    self.timeL.text = [NSString stringWithFormat:@"%@-%@",_item.startTime,_item.endTime];
    self.priceL.text = _item.couponAmt;
    self.tipL.text = _item.fiftyDesc;//[NSString stringWithFormat:@"满%@元可用",_item.fiftyAmt];
    
    CGFloat price = [_item.couponAmt floatValue];
    NSString *imageName = nil;
    UIColor *color = nil;
    if (price<50) {
        imageName = @"CouponList_Unused_0_50";
        color = [UIColor colorFromHexString:@"74D2D4"];
    }else if (price<100) {
        imageName = @"CouponList_Unused_50_100";
        color = [UIColor colorFromHexString:@"FFBE3B"];
    }else if (price<500) {
        imageName = @"CouponList_Unused_100_500";
        color = [UIColor colorFromHexString:@"FF91BB"];
    }else{
        imageName = @"CouponList_Unused_500";
        color = [UIColor colorFromHexString:@"FF9673"];
    }
    self.icon.image = [UIImage imageNamed:imageName];
    self.useBtn.layer.borderColor = color.CGColor;
    [self.useBtn setTitleColor:color forState:UIControlStateNormal];
    
}


@end
