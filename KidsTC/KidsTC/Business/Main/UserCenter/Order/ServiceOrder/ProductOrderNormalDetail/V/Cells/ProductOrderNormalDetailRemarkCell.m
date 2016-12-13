//
//  ProductOrderNormalDetailRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailRemarkCell.h"

@interface ProductOrderNormalDetailRemarkCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@end

@implementation ProductOrderNormalDetailRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    self.remarkL.attributedText = data.remarksStr;
}

@end
