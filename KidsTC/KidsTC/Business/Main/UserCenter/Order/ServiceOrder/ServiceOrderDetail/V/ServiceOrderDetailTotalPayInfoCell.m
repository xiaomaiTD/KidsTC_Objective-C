//
//  ServiceOrderDetailTotalPayInfoCell.m
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceOrderDetailTotalPayInfoCell.h"

@interface ServiceOrderDetailTotalPayInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation ServiceOrderDetailTotalPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.line.hidden = YES;
    self.HLineConstraintHeight.constant = LINE_H;
    self.totalPriceLabel.textColor = COLOR_PINK;
}
- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%.1f",data.totalPrice];
}


@end
