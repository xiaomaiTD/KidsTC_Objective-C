//
//  WolesaleProductDetailV2InfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2InfoCell.h"

@interface WolesaleProductDetailV2InfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *subL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WolesaleProductDetailV2InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    
    WholesaleProductDetailBase *base = data.fightGroupBase;
    WolesaleProductDetailV2Data *detailV2 = base.detailV2;
    self.nameL.text = base.productName;
    self.subL.attributedText = detailV2.attPpromotionText;
    self.priceL.text = base.fightGroupPrice;
    self.timeL.text = detailV2.timeDesc;
    
}

@end
