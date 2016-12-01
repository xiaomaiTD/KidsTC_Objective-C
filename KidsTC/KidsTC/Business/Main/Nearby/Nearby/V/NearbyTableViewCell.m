//
//  NearbyTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewCell.h"

@interface NearbyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@end

@implementation NearbyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bgView.layer.borderWidth = LINE_H;
}


@end
