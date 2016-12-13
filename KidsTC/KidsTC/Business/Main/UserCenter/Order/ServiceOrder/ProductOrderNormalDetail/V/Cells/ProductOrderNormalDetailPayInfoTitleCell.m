//
//  ProductOrderNormalDetailPayInfoTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailPayInfoTitleCell.h"

@interface ProductOrderNormalDetailPayInfoTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderNormalDetailPayInfoTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    self.payTypeL.text = data.paytypename;
}

@end
