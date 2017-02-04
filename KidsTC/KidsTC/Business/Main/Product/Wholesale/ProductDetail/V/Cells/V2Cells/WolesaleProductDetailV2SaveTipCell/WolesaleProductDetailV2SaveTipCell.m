//
//  WolesaleProductDetailV2SaveTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2SaveTipCell.h"

@interface WolesaleProductDetailV2SaveTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *saveL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation WolesaleProductDetailV2SaveTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.layer.cornerRadius = 2;
    self.tipL.layer.masksToBounds = YES;
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    
    WholesaleProductDetailBase *base = data.fightGroupBase;
    WolesaleProductDetailV2Data *detailV2 = base.detailV2;
    self.saveL.text = [NSString stringWithFormat:@"%@组家庭拼团，拼团成功每家省",base.openGroupUserCount];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",detailV2.savingPrice];
}

@end
