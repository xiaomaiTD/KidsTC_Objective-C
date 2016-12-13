//
//  NearbyCalendarToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBar.h"
#import "Colours.h"
#import "ToolBox.h"
#import "NSDate+ZP.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"

#import "NearbyCalendarToolBarItemView.h"
#import "NearbyCalendarToolBarDateView.h"
#import "NearbyCalendarToolBarCategoryView.h"

static CGFloat const kAnimateDuration = 0.3;

CGFloat const kNearbyCalendarToolBarH = 44;

@interface NearbyCalendarToolBar ()<NearbyCalendarToolBarDateViewDelegate,NearbyCalendarToolBarCategoryViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet NearbyCalendarToolBarItemView *dateItemView;
@property (weak, nonatomic) IBOutlet NearbyCalendarToolBarItemView *categoryItemView;
@property (weak, nonatomic) NearbyCalendarToolBarItemView *currentItemView;

@property (weak, nonatomic) IBOutlet NearbyCalendarToolBarDateView *dateView;
@property (weak, nonatomic) IBOutlet NearbyCalendarToolBarCategoryView *categoryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryViewTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryViewH;

@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation NearbyCalendarToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
    
    [self setupToolBarItemView];
    
    self.dateItemView.tag = NearbyCalendarToolBarItemViewTypeDate;
    self.categoryItemView.tag = NearbyCalendarToolBarItemViewTypeCategory;
    self.dateItemView.actionBlock = ^(NearbyCalendarToolBarItemView *itemView){
        [self action:itemView];
    };
    self.categoryItemView.actionBlock = ^(NearbyCalendarToolBarItemView *itemView){
        [self action:itemView];
    };
    
    self.dateViewTopMargin.constant = -self.dateViewH.constant - 4;
    self.categoryViewTopMargin.constant = -self.categoryViewH.constant - 4;
    
    self.dateView.delegate = self;
    self.categoryView.delegate = self;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.categoryViewH.constant = [self.categoryView contentHeight];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self action:_currentItemView];
}

- (void)setupToolBarItemView {
    [self.dateItemView setTitle:[NSString zp_stringWithDate:[NSDate date] Format:DF_yMd]];
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

- (void)action:(NearbyCalendarToolBarItemView *)senderItemView {
    if (_currentItemView == senderItemView) {
        if (_currentItemView.state == UIControlStateNormal) {
            _currentItemView.state = UIControlStateSelected;
        }else if (_currentItemView.state == UIControlStateSelected) {
            _currentItemView.state = UIControlStateNormal;
        }
    }else{
        _currentItemView.state = UIControlStateNormal;
        senderItemView.state = UIControlStateSelected;
        _currentItemView = senderItemView;
    }
    
    NearbyCalendarToolBarItemViewType type = (NearbyCalendarToolBarItemViewType)_currentItemView.tag;
    if (_currentItemView.state == UIControlStateSelected) {
        [self showActionType:type];
    }else{
        [self hideActionType:type];
    }
}

- (void)showActionType:(NearbyCalendarToolBarItemViewType)type {
    NSLayoutConstraint *topMargin_hide, *height_hide, *topMargin_show, *height_show;
    switch (type) {
        case NearbyCalendarToolBarItemViewTypeDate:
        {
            topMargin_hide = self.categoryViewTopMargin;
            height_hide = self.categoryViewH;
            topMargin_show = self.dateViewTopMargin;
            height_show = self.dateViewH;
        }
            break;
        case NearbyCalendarToolBarItemViewTypeCategory:
        {
            topMargin_hide = self.dateViewTopMargin;
            height_hide = self.dateViewH;
            topMargin_show = self.categoryViewTopMargin;
            height_show = self.categoryViewH;
        }
            break;
    }
    if(!self.isAnimating){
        [self hideViewWithTop:topMargin_hide height:height_hide completion:^{
            [self showViewWithTop:topMargin_show height:height_show completion:nil];
        }];
    }
}

- (void)hideActionType:(NearbyCalendarToolBarItemViewType)type {
    NSLayoutConstraint *topMargin_hide, *height_hide;
    switch (type) {
        case NearbyCalendarToolBarItemViewTypeDate:
        {
            topMargin_hide = self.dateViewTopMargin;
            height_hide = self.dateViewH;
        }
            break;
        case NearbyCalendarToolBarItemViewTypeCategory:
        {
            topMargin_hide = self.categoryViewTopMargin;
            height_hide = self.categoryViewH;
        }
            break;
    }
    if(!self.isAnimating)[self hideViewWithTop:topMargin_hide height:height_hide completion:nil];
}

- (void)hideViewWithTop:(NSLayoutConstraint *)topMargin height:(NSLayoutConstraint *)height completion:(void(^)())completion{
    if (!topMargin || !height) {
        if (completion) completion();
    }else{
        [UIView animateWithDuration:kAnimateDuration animations:^{
            topMargin.constant = - height.constant - 4;
            self.backgroundColor = [UIColor clearColor];
            [self layoutIfNeeded];
            self.isAnimating = YES;
        } completion:^(BOOL finished) {
            CGRect frame = self.frame;
            frame.size.height = kNearbyCalendarToolBarH;
            self.frame = frame;
            [self layoutIfNeeded];
            if (completion) completion();
            self.isAnimating = NO;
        }];
    }
}

- (void)showViewWithTop:(NSLayoutConstraint *)topMargin height:(NSLayoutConstraint *)height completion:(void(^)())completion{
    if (!topMargin || !height) {
        if (completion) completion();
    }else{
        CGRect frame = self.frame;
        frame.size.height = SCREEN_HEIGHT - 64;
        self.frame = frame;
        [self layoutIfNeeded];
        self.isAnimating = YES;
        [UIView animateWithDuration:kAnimateDuration animations:^{
            topMargin.constant = 0;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completion) completion();
            self.isAnimating = NO;
        }];
    }
}

#pragma mark - NearbyCalendarToolBarDateViewDelegate

- (void)nearbyCalendarToolBarDateView:(NearbyCalendarToolBarDateView *)view didSelectDate:(NSDate *)date {
    [self didSelect:date type:NearbyCalendarToolBarActionTypeDidSelectDate title:[NSString zp_stringWithDate:date Format:DF_yMd]];
}

#pragma mark - NearbyCalendarToolBarCategoryViewDelegate

- (void)nearbyCalendarToolBarCategoryView:(NearbyCalendarToolBarCategoryView *)view didSelectItem:(NearbyCalendarToolBarCategoryItem *)item {
    [self didSelect:item type:NearbyCalendarToolBarActionTypeDidSelectCategory title:item.title];
}

- (void)didSelect:(id)value type:(NearbyCalendarToolBarActionType)type title:(NSString *)title {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self action:_currentItemView];
        if ([self.delegate respondsToSelector:@selector(nearbyCalendarToolBar:actionType:value:)]) {
            [self.delegate nearbyCalendarToolBar:self actionType:type value:value];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kAnimateDuration+0.01) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_currentItemView setTitle:title];
            self.userInteractionEnabled = YES;
        });
    });
}
@end
