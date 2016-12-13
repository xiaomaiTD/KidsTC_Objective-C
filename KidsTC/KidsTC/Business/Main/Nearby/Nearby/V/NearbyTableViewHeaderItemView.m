//
//  NearbyTableViewHeaderItemView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewHeaderItemView.h"

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

- (void)setType:(NearbyTableViewHeaderActionType)type {
    _type = type;
    NSString *mainTitleL,*subTitleL,*imageName;
    switch (type) {
        case NearbyTableViewHeaderActionTypeNursery:
        {
            mainTitleL = @"育儿室";
            subTitleL = @"紧急情况点这里";
            imageName = @"Nearby_nursery";
        }
            break;
        case NearbyTableViewHeaderActionTypeExhibition:
        {
            mainTitleL = @"展览馆";
            subTitleL = @"要学习到这里";
            imageName = @"Nearby_exhibition";
        }
            break;
        case NearbyTableViewHeaderActionTypeCalendar:
        {
            mainTitleL = @"日历";
            subTitleL = @"用日历搜活动";
            imageName = @"Nearby_date";
        }
            break;
    }
    self.mainTitleL.text = mainTitleL;
    self.subTitleL.text = subTitleL;
    self.icon.image = [UIImage imageNamed:imageName];
}
- (IBAction)action:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(nearbyTableViewHeaderItemView:actionType:value:)]) {
        [self.delegate nearbyTableViewHeaderItemView:self actionType:_type value:nil];
    }
}

@end
