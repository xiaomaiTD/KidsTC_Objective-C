//
//  WolesaleProductDetailProductInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailProductInfoCell.h"
#import "UIImageView+WebCache.h"

@interface WolesaleProductDetailProductInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *originalPriceView;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceTipL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;

@property (weak, nonatomic) IBOutlet UIView *teamPriceView;
@property (weak, nonatomic) IBOutlet UILabel *teamPriceTipL;
@property (weak, nonatomic) IBOutlet UILabel *teamPriceL;

@end

@implementation WolesaleProductDetailProductInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    
    self.originalPriceView.layer.cornerRadius = 4;
    self.originalPriceView.layer.masksToBounds = YES;
    self.originalPriceView.layer.borderColor = [UIColor colorFromHexString:@"CCCCCC"].CGColor;
    self.originalPriceView.layer.borderWidth = 1;
    
    self.teamPriceView.layer.cornerRadius = 4;
    self.teamPriceView.layer.masksToBounds = YES;
    self.teamPriceView.layer.borderColor = [UIColor colorFromHexString:@"F36863"].CGColor;
    self.teamPriceView.layer.borderWidth = 1;
    
    
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    WholesaleProductDetailBase *fightGroupBase = data.fightGroupBase;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:fightGroupBase.productImage] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.nameL.text = fightGroupBase.productName;
    
    self.originalPriceL.text = fightGroupBase.platFormPrice;
    self.teamPriceTipL.text = [NSString stringWithFormat:@"%@人团",fightGroupBase.openGroupUserCount];
    self.teamPriceL.text = fightGroupBase.fightGroupPrice;
}

@end
