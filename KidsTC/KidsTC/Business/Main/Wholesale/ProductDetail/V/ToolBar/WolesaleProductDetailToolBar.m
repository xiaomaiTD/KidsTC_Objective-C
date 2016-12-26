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
@property (weak, nonatomic) IBOutlet UIView *homeBGView;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeLineH;

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
    
    self.homeLineH.constant = LINE_H;
    self.originalBGView.backgroundColor = [UIColor colorFromHexString:@"FF9C9C"];
    self.teamBGView.backgroundColor = [UIColor colorFromHexString:@"F36863"];
    
}


@end
