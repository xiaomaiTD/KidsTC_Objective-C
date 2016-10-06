//
//  NotificationCenterViewCell.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "NotificationCenterViewCell.h"

@interface NotificationCenterViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation NotificationCenterViewCell

- (void)setItem:(NotificationCenterItem *)item{
    _item = item;
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.content;
    self.timeLabel.text = item.updateTime;
    self.contentView.alpha = (item.status==NotificationStatusUnread)?1:0.5;
}

@end
