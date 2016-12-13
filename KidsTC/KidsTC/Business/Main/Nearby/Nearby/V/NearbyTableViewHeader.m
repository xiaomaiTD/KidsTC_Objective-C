//
//  NearbyTableViewHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewHeader.h"


CGFloat const kNearbyTableViewHeaderH = 112;

@interface NearbyTableViewHeader ()<NearbyTableViewHeaderItemViewDelegate>
@property (weak, nonatomic) IBOutlet NearbyTableViewHeaderItemView *leftItemView;
@property (weak, nonatomic) IBOutlet NearbyTableViewHeaderItemView *rightItemView;
@end

@implementation NearbyTableViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftItemView.type = NearbyTableViewHeaderActionTypeNursery;
    self.rightItemView.type = NearbyTableViewHeaderActionTypeCalendar;
    self.leftItemView.delegate = self;
    self.rightItemView.delegate = self;
}

- (void)setPlaceInfo:(NearbyPlaceInfo *)placeInfo {
    _placeInfo = placeInfo;
    NearbyTableViewHeaderActionType actionType = NearbyTableViewHeaderActionTypeNursery;
    switch (_placeInfo.placeType) {
        case NurseryTypeNursery:
        {
            actionType = NearbyTableViewHeaderActionTypeNursery;
        }
            break;
        case NurseryTypeExhibitionHall:
        {
            actionType = NearbyTableViewHeaderActionTypeExhibition;
        }
            break;
        default:
        {
            actionType = NearbyTableViewHeaderActionTypeNursery;
        }
            break;
    }
    self.leftItemView.type = actionType;
}

- (void)nearbyTableViewHeaderItemView:(NearbyTableViewHeaderItemView *)view actionType:(NearbyTableViewHeaderActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyTableViewHeader:actionType:value:)]) {
        [self.delegate nearbyTableViewHeader:self actionType:type value:_placeInfo];
    }
}

@end
