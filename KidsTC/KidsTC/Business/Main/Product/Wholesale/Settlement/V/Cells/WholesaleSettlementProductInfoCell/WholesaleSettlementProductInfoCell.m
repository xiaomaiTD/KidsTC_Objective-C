//
//  WholesaleSettlementProductInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementProductInfoCell.h"
#import "UIImageView+WebCache.h"

@interface WholesaleSettlementProductInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceTipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WholesaleSettlementProductInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:data.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = data.productName;
    self.priceTipL.text = [NSString stringWithFormat:@"%@人拼团价：",data.openGroupUserCount];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",data.fightGroupPrice];
}

@end
