//
//  NurseryAnnoView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryAnnoView.h"
#import "UIImageView+WebCache.h"

@interface NurseryAnnoView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *nearbyBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@end

@implementation NurseryAnnoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
    self.distanceL.textColor = COLOR_YELL;
    [self.gotoBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    [self.nearbyBtn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
    self.gotoBtn.tag = NurseryAnnoViewActionTypeRoute;
    self.nearbyBtn.tag = NurseryAnnoViewActionTypeNearby;
    
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = LINE_H;
    
    [self layoutIfNeeded];
}

- (void)setItem:(NurseryItem *)item {
    _item = item;
    if (item.pictures.count>0) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:item.pictures.firstObject] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    }
    self.nameL.text = item.name;
    self.addressL.text = item.address;
    self.distanceL.text = item.distanceDesc;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(nurseryAnnoView:actionType:value:)]) {
        [self.delegate nurseryAnnoView:self actionType:sender.tag value:nil];
    }
}

@end
