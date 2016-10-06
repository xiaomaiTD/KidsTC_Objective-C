//
//  WelfareStoreHospitalAnnotationTipView.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelfareStoreHospitalAnnotationTipView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface WelfareStoreHospitalAnnotationTipView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *nearbyBtn;
@end

@implementation WelfareStoreHospitalAnnotationTipView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.distanceLabel.textColor = COLOR_YELL;
    [self.gotoBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [self.nearbyBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    
    self.phoneBtn.tag = WelfareStoreHospitalAnnotationTipViewActionTypePhone;
    self.gotoBtn.tag = WelfareStoreHospitalAnnotationTipViewActionTypeGoto;
    self.nearbyBtn.tag = WelfareStoreHospitalAnnotationTipViewActionTypeNearby;
    
    self.contentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.contentView.layer.borderWidth = LINE_H;
}

- (void)setItem:(WelfareStoreItem *)item{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.desc;
    self.distanceLabel.text = item.distance;
    self.phoneBtn.hidden = !(item.mobile.length>0);
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(welfareStoreHospitalAnnotationTipView:actionType:)]) {
        [self.delegate welfareStoreHospitalAnnotationTipView:self actionType:(WelfareStoreHospitalAnnotationTipViewActionType)sender.tag];
    }
}
@end
