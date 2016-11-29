//
//  CouponListExpiredCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListExpiredCell.h"
#import "Colours.h"

@interface CouponListExpiredCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation CouponListExpiredCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
}

- (IBAction)action:(UIButton *)sender {
    
}

- (void)setItem:(CouponListItem *)item {
    _item = item;
    self.nameL.text = _item.couponName;
    self.timeL.text = [NSString stringWithFormat:@"%@-%@",_item.startTime,_item.endTime];
    self.priceL.text = _item.couponAmt;
    self.tipL.text = _item.fiftyDesc;//[NSString stringWithFormat:@"满%@元可用",_item.fiftyAmt];
    
}

@end
