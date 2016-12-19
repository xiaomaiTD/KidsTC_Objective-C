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
    self.leftItemView.delegate = self;
    self.rightItemView.delegate = self;
}

- (void)setPlaceInfo:(NearbyPlaceInfo *)placeInfo {
    _placeInfo = placeInfo;
    self.leftItemView.data = placeInfo.leftData;
    self.rightItemView.data = placeInfo.rightData;
}

#pragma mark - NearbyTableViewHeaderItemViewDelegate

- (void)nearbyTableViewHeaderItemView:(NearbyTableViewHeaderItemView *)view actionType:(NurseryType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyTableViewHeader:actionType:value:)]) {
        [self.delegate nearbyTableViewHeader:self actionType:type value:value];
    }
}

@end
