//
//  WelfareStoreLoveHouseCell.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelfareStoreLoveHouseCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface WelfareStoreLoveHouseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *nearbyBtn;
@end

@implementation WelfareStoreLoveHouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.distanceLabel.textColor = COLOR_YELL;
    [self.gotoBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [self.nearbyBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    
    self.gotoBtn.tag = WelfareStoreLoveHouseCellActionTypeGoto;
    self.nearbyBtn.tag = WelfareStoreLoveHouseCellActionTypeNearby;
}

- (void)setItem:(WelfareStoreItem *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.desc;
    self.distanceLabel.text = item.distance;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(welfareStoreLoveHouseCell:actionType:)]) {
        [self.delegate welfareStoreLoveHouseCell:self actionType:(WelfareStoreLoveHouseCellActionType)sender.tag];
    }
}
@end
