//
//  CollectProductReduceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceCell.h"
#import "Colours.h"

@interface CollectProductReduceCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerIconH;
@property (weak, nonatomic) IBOutlet UILabel *reduceL;
@end

@implementation CollectProductReduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    self.priceL.textColor = COLOR_PINK;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = 1;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bannerIcon.layer.borderWidth = 1;
    self.bannerIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    self.nameL.textColor = [UIColor colorFromHexString:@"333333"];
    self.addressL.textColor = [UIColor colorFromHexString:@"999999"];
    self.statusL.textColor = [UIColor colorFromHexString:@"999999"];
    self.priceL.textColor = [UIColor colorFromHexString:@"F36863"];
    self.reduceL.textColor = [UIColor colorFromHexString:@"7EBCF2"];
}


@end
