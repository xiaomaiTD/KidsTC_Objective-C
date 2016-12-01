//
//  NearbyFilterToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterToolBar.h"
#import "Colours.h"
#import "NearbyFilterToolBarItemView.h"

@interface NearbyFilterToolBar ()
@property (weak, nonatomic) IBOutlet NearbyFilterToolBarItemView *dateItemView;
@property (weak, nonatomic) IBOutlet NearbyFilterToolBarItemView *categoryItemView;

@property (nonatomic, weak) NearbyFilterToolBarItemView *currentItemView;
@end

@implementation NearbyFilterToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupToolBarItemView];
    self.dateItemView.tag = NearbyFilterToolBarActionTypeDate;
    self.categoryItemView.tag = NearbyFilterToolBarActionTypeCategory;
    self.dateItemView.actionBlock = ^(NearbyFilterToolBarItemView *itemView){
        [self action:itemView];
    };
    self.categoryItemView.actionBlock = ^(NearbyFilterToolBarItemView *itemView){
        [self action:itemView];
    };
    [self setSelectedItemView:self.dateItemView];
}

- (void)setupToolBarItemView {
    [self.dateItemView setIconImage:[UIImage imageNamed:@"Nearby_date_unsel"] forState:UIControlStateNormal];
    [self.dateItemView setTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
    [self.dateItemView setArrowImage:[UIImage imageNamed:@"Nearby_down"] forState:UIControlStateNormal];
    [self.dateItemView setIconImage:[UIImage imageNamed:@"Nearby_date_sel"] forState:UIControlStateSelected];
    [self.dateItemView setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.dateItemView setArrowImage:[UIImage imageNamed:@"Nearby_up"] forState:UIControlStateSelected];
    
    [self.categoryItemView setIconImage:[UIImage imageNamed:@"Nearby_category_unsel"] forState:UIControlStateNormal];
    [self.categoryItemView setTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
    [self.categoryItemView setArrowImage:[UIImage imageNamed:@"Nearby_down"] forState:UIControlStateNormal];
    [self.categoryItemView setIconImage:[UIImage imageNamed:@"Nearby_category_sel"] forState:UIControlStateSelected];
    [self.categoryItemView setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.categoryItemView setArrowImage:[UIImage imageNamed:@"Nearby_up"] forState:UIControlStateSelected];
}

- (void)action:(NearbyFilterToolBarItemView *)senderItemView {
    if (_currentItemView == senderItemView) return;
    [self setSelectedItemView:senderItemView];
    if ([self.delegate respondsToSelector:@selector(nearbyFilterToolBar:actionType:value:)]) {
        [self.delegate nearbyFilterToolBar:self actionType:(NearbyFilterToolBarActionType)senderItemView.tag value:nil];
    }
}

- (void)setSelectedItemView:(NearbyFilterToolBarItemView *)senderItemView {
    _currentItemView.state = UIControlStateNormal;
    senderItemView.state = UIControlStateSelected;
    _currentItemView = senderItemView;
}

@end
