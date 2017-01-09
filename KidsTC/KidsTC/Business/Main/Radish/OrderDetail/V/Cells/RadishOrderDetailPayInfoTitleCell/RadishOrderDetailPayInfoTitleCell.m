//
//  RadishOrderDetailPayInfoTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailPayInfoTitleCell.h"

@interface RadishOrderDetailPayInfoTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation RadishOrderDetailPayInfoTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(RadishOrderDetailData *)data {
    [super setData:data];
    self.payTypeL.text = data.paytypename;
}

@end
