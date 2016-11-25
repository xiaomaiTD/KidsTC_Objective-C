//
//  ServiceSettlementPickCouponViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/13/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementPickCouponViewCell.h"

@interface ServiceSettlementPickCouponViewCell ()
@property (weak, nonatomic) IBOutlet UIView *shapeView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cuttingLineConstraintWidth;
@end

@implementation ServiceSettlementPickCouponViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.priceLabel.textColor = COLOR_PINK;
    self.cuttingLineConstraintWidth.constant = LINE_H;
    self.shapeView.layer.cornerRadius = 4;
    self.shapeView.layer.masksToBounds = YES;
    self.shapeView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.shapeView.layer.borderWidth = 1;
}

- (void)setItem:(ServiceSettlementCouponItem *)item {
    _item = item;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%0.0f",item.couponAmt];
    self.nameLabel.text = item.name;
    self.descLabel.text = [NSString stringWithFormat:@"· %@",item.desc];
    self.timeLabel.text = [NSString stringWithFormat:@"· %@至%@",item.startTime,item.endTime];
    NSString *imageName = item.selected?@"select_yes":@"select_no";
    self.checkImageView.image = [UIImage imageNamed:imageName];
    self.shapeView.layer.borderColor = ([item.selected?COLOR_PINK:[UIColor lightGrayColor] colorWithAlphaComponent:0.3]).CGColor;
}


@end
