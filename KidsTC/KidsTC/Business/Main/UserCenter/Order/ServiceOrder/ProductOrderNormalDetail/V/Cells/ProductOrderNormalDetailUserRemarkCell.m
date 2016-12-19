//
//  ProductOrderNormalDetailUserRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailUserRemarkCell.h"

@interface ProductOrderNormalDetailUserRemarkCell ()
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductOrderNormalDetailUserRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    self.remarkL.attributedText = data.userRemarkStr;
}

@end
