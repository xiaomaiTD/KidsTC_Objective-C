//
//  WelfareStoreHospitalCell.m
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelfareStoreHospitalCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface WelfareStoreHospitalCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *nearbyBtn;

@end

@implementation WelfareStoreHospitalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.distanceLabel.textColor = COLOR_YELL;
    [self.gotoBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [self.nearbyBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    
    self.phoneBtn.tag = WelfareStoreHospitalCellActionTypePhone;
    self.gotoBtn.tag = WelfareStoreHospitalCellActionTypeGoto;
    self.nearbyBtn.tag = WelfareStoreHospitalCellActionTypeNearby;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(welfareStoreHospitalCell:actionType:)]) {
        [self.delegate welfareStoreHospitalCell:self actionType:(WelfareStoreHospitalCellActionType)sender.tag];
    }
}

- (void)setItem:(WelfareStoreItem *)item{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.desc;
    self.distanceLabel.text = item.distance;
    self.phoneBtn.hidden = !(item.mobile.length>0);
}

@end
