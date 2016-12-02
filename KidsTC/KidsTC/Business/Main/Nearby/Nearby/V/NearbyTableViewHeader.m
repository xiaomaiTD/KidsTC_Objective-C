//
//  NearbyTableViewHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyTableViewHeader.h"
#import "NearbyTableViewHeaderItemView.h"

CGFloat const kNearbyTableViewHeaderH = 112;

@interface NearbyTableViewHeader ()
@property (weak, nonatomic) IBOutlet NearbyTableViewHeaderItemView *leftItemView;
@property (weak, nonatomic) IBOutlet NearbyTableViewHeaderItemView *rightItemView;
@end

@implementation NearbyTableViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftItemView.tag = NearbyTableViewHeaderActionTypeNursery;
    self.rightItemView.tag = NearbyTableViewHeaderActionTypeCalendar;
    self.leftItemView.actionBlock = ^{
        [self action:self.leftItemView.tag];
    };
    self.rightItemView.actionBlock = ^{
        [self action:self.rightItemView.tag];
    };
}

- (void)action:(NearbyTableViewHeaderActionType)type {
    if ([self.delegate respondsToSelector:@selector(nearbyTableViewHeader:actionType:value:)]) {
        [self.delegate nearbyTableViewHeader:self actionType:type value:nil];
    }
}



@end
