//
//  AccountCenterActivitiesCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterActivitiesCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface AccountCenterActivitiesCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation AccountCenterActivitiesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setActivity:(AccountCenterActivity *)activity {
    _activity = activity;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_activity.ImageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.label.text = _activity.name;
}
- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(self.activity.segueModel);
    }
}

@end
