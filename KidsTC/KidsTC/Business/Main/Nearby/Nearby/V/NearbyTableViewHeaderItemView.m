//
//  NearbyTableViewHeaderItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewHeaderItemView.h"
#import "UIImageView+WebCache.h"

@interface NearbyTableViewHeaderItemView ()
@property (nonatomic, weak) IBOutlet UIView *titleBGView;
@property (nonatomic, weak) IBOutlet UILabel *mainTitleL;
@property (nonatomic, weak) IBOutlet UILabel *subTitleL;
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UIButton *btn;
@end

@implementation NearbyTableViewHeaderItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (void)setData:(NearbyPlaceInfoData *)data {
    _data = data;
    self.hidden = _data==nil;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_data.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.mainTitleL.text = _data.title;
    self.subTitleL.text = _data.desc;
}

- (IBAction)action:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(nearbyTableViewHeaderItemView:actionType:value:)]) {
        [self.delegate nearbyTableViewHeaderItemView:self actionType:_data.placeType value:_data];
    }
}

@end
