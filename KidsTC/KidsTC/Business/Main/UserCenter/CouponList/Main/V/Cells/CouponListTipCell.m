//
//  CouponListTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListTipCell.h"
#import "Colours.h"

@interface CouponListTipCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation CouponListTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setTip:(NSString *)tip {
    _tip = tip;
    self.tipL.text = _tip;
}

@end
