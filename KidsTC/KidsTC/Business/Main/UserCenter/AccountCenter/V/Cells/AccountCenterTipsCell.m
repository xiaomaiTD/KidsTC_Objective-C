//
//  AccountCenterTipsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterTipsCell.h"
#import "Colours.h"

@interface AccountCenterTipsCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation AccountCenterTipsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipL.textColor = [UIColor colorFromHexString:@"555555"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
