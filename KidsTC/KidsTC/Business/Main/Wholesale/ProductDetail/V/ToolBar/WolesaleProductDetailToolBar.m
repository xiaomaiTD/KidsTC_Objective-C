//
//  WolesaleProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailToolBar.h"

CGFloat const kWolesaleProductDetailToolBarH = 49;

@interface WolesaleProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIView *shareBGView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareLineH;

@property (weak, nonatomic) IBOutlet UIView *originalBGView;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceTipL;

@property (weak, nonatomic) IBOutlet UIView *teamBGView;
@property (weak, nonatomic) IBOutlet UILabel *teamPriceL;
@property (weak, nonatomic) IBOutlet UILabel *teamPriceTipL;

@end

@implementation WolesaleProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shareLineH.constant = LINE_H;
    self.originalBGView.backgroundColor = [UIColor colorFromHexString:@"FF9C9C"];
    self.teamBGView.backgroundColor = [UIColor colorFromHexString:@"F36863"];
}

- (void)setData:(WolesaleProductDetailData *)data {
    _data = data;
    WholesaleProductDetailBase *base = data.fightGroupBase;
    self.hidden = base == nil;
    self.originalPriceL.text = base.platFormPrice;
    self.teamPriceL.text = base.fightGroupPrice;
    self.teamPriceTipL.text = [NSString stringWithFormat:@"%@人团",base.openGroupUserCount];
}


@end
