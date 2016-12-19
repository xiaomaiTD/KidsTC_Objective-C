//
//  ProductOrderFreeDetailUserRemarkCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailUserRemarkCell.h"

@interface ProductOrderFreeDetailUserRemarkCell ()
@property (weak, nonatomic) IBOutlet UILabel *remarkL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderFreeDetailUserRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    self.remarkL.attributedText = infoData.userRemarkStr;
}

@end
