//
//  NearbyFilterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterView.h"
#import "NearbyFilterToolBar.h"
#import "NearbyFilterToolBarDateView.h"
#import "NearbyFilterToolBarCategoryView.h"
#import "NearbyFilterCell.h"

static NSString *const CellID = @"NearbyFilterCell";
static CGFloat const kAnimateDuration = 0.3;

@interface NearbyFilterView ()<NearbyFilterToolBarDelegate,NearbyFilterToolBarDateViewDelegate,NearbyFilterToolBarCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NearbyFilterToolBar *toolBar;
@property (weak, nonatomic) IBOutlet NearbyFilterToolBarDateView *dateView;
@property (weak, nonatomic) IBOutlet NearbyFilterToolBarCategoryView *categoryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryViewTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryViewH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverViewH;

@end

@implementation NearbyFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateViewTopMargin.constant = -self.dateViewH.constant;
    self.categoryViewTopMargin.constant = -self.categoryViewH.constant;
    self.coverView.backgroundColor = [UIColor clearColor];
    self.coverViewH.constant = 0;
    self.toolBar.delegate = self;
    self.dateView.delegate = self;
    self.categoryView.delegate = self;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.categoryViewH.constant = [self.categoryView contentHeight];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(nearbyFilterView:actionType:value:)]) {
        [self.delegate nearbyFilterView:self actionType:NearbyFilterViewActionTypeBack value:nil];
    }
}

#pragma mark - NearbyFilterToolBarDelegate

- (void)nearbyFilterToolBar:(NearbyFilterToolBar *)toolBar actionType:(NearbyFilterToolBarActionType)type value:(id)value {
    NSLayoutConstraint *topMargin_hide, *height_hide, *topMargin_show, *height_show;
    switch (type) {
        case NearbyFilterToolBarActionTypeDate:
        {
            topMargin_hide = self.categoryViewTopMargin;
            height_hide = self.categoryViewH;
            topMargin_show = self.dateViewTopMargin;
            height_show = self.dateViewH;
        }
            break;
        case NearbyFilterToolBarActionTypeCategory:
        {
            topMargin_hide = self.dateViewTopMargin;
            height_hide = self.dateViewH;
            topMargin_show = self.categoryViewTopMargin;
            height_show = self.categoryViewH;
        }
            break;
    }
    [self hideViewWithTop:topMargin_hide height:height_hide completion:^{
        [self showViewWithTop:topMargin_show height:height_show completion:nil];
    }];
}

- (void)hideViewWithTop:(NSLayoutConstraint *)topMargin height:(NSLayoutConstraint *)height completion:(void(^)())completion{
    if (!topMargin || !height) {
        if (completion) completion();
    }else{
        [UIView animateWithDuration:kAnimateDuration animations:^{
            topMargin.constant = - height.constant;
            self.coverView.backgroundColor = [UIColor clearColor];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.coverViewH.constant = 0;
            [self layoutIfNeeded];
            if (completion) completion();
        }];
    }
}

- (void)showViewWithTop:(NSLayoutConstraint *)topMargin height:(NSLayoutConstraint *)height completion:(void(^)())completion{
    if (!topMargin || !height) {
        if (completion) completion();
    }else{
        self.coverViewH.constant = SCREEN_HEIGHT - 64;
        [self layoutIfNeeded];
        [UIView animateWithDuration:kAnimateDuration animations:^{
            topMargin.constant = 0;
            self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completion) completion();
        }];
    }
}

#pragma mark - NearbyFilterToolBarDateViewDelegate

- (void)nearbyFilterToolBarDateView:(NearbyFilterToolBarDateView *)view didSelectDate:(NSDate *)date {
    if ([self.delegate respondsToSelector:@selector(nearbyFilterView:actionType:value:)]) {
        [self.delegate nearbyFilterView:self actionType:NearbyFilterViewActionTypeDidSelectDate value:date];
    }
}

#pragma mark - NearbyFilterToolBarCategoryViewDelegate

- (void)nearbyFilterToolBarCategoryView:(NearbyFilterToolBarCategoryView *)view didSelectItem:(NearbyFilterToolBarCategoryItem *)item {
    if ([self.delegate respondsToSelector:@selector(nearbyFilterView:actionType:value:)]) {
        [self.delegate nearbyFilterView:self actionType:NearbyFilterViewActionTypeDidSelectCategory value:item];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}


@end
