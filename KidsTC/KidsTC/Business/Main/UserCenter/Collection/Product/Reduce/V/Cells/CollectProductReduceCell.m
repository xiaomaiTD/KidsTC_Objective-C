//
//  CollectProductReduceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceCell.h"

@interface CollectProductReduceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerIcon;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@end

@implementation CollectProductReduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.priceL.textColor = COLOR_PINK;
    self.icon.layer.cornerRadius = CGRectGetWidth(self.icon.bounds) * 0.5;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bannerIcon.layer.borderWidth = LINE_H;
    self.bannerIcon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}


@end
