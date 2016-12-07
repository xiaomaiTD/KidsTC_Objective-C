//
//  SearchResultToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultToolBar.h"
#import "SearchResultToolBarButton.h"
#import "NSString+Category.h"

#import "SearchFactorAreaView.h"
#import "SearchFactorSortView.h"
#import "SearchFactorFilterView.h"

static CGFloat const kAnimateDuration = 0.3;
CGFloat const kSearchResultToolBarH = 44;

@interface SearchResultToolBar ()<SearchFactorAreaViewDelegate,SearchFactorSortViewDelegate,SearchFactorFilterViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *btnsView;

@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UIButton *sortBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UIView *filterBtnTip;

@property (nonatomic, strong) SearchFactorAreaView *areaView;
@property (nonatomic, strong) SearchFactorSortView *sortView;
@property (nonatomic, strong) SearchFactorFilterView *filterView;

@property (nonatomic, weak) UIButton *currentBtn;
@property (nonatomic, weak) UIView *currentView;

@property (nonatomic, assign) BOOL isChangingView;
@end

@implementation SearchResultToolBar

- (SearchFactorAreaView *)areaView {
    if (!_areaView) {
        _areaView = [self viewWithNib:@"SearchFactorAreaView"];
        _areaView.delegate = self;
        [self insertSubview:_areaView atIndex:0];
    }
    return _areaView;
}

- (SearchFactorSortView *)sortView {
    if (!_sortView) {
        _sortView = [self viewWithNib:@"SearchFactorSortView"];
        _sortView.delegate = self;
        [self insertSubview:_sortView atIndex:0];
    }
    return _sortView;
}

- (SearchFactorFilterView *)filterView {
    if (!_filterView) {
        _filterView = [self viewWithNib:@"SearchFactorFilterView"];
        _filterView.delegate = self;
        [self insertSubview:_filterView atIndex:0];
    }
    return _filterView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.filterBtnTip.layer.cornerRadius = CGRectGetWidth(self.filterBtnTip.frame) * 0.5;
    self.filterBtnTip.layer.masksToBounds = YES;
    self.filterBtnTip.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat view_y = CGRectGetMaxY(self.btnsView.frame);
    
    UIView *nextShowView = nil;
    if (self.currentBtn.selected) {
        if (self.currentBtn == self.areaBtn) {
            nextShowView = self.areaView;
        }else if (self.currentBtn == self.sortBtn) {
            nextShowView = self.sortView;
        }else if (self.currentBtn == self.filterBtn) {
            nextShowView = self.filterView;
        }
    }
    
    CGFloat area_h = self.areaView.contentHeight;
    CGFloat area_y = (nextShowView == self.areaView)?view_y:(view_y - area_h);
    self.areaView.frame = CGRectMake(0, area_y, self_w, area_h);
    
    CGFloat sort_h = self.sortView.contentHeight;
    CGFloat sort_y = (nextShowView == self.sortView)?view_y:(view_y - sort_h);
    self.sortView.frame = CGRectMake(0, sort_y, self_w, sort_h);
    
    CGFloat filter_h = self.filterView.contentHeight;
    CGFloat filter_y = (nextShowView == self.filterView)?view_y:(view_y - filter_h);
    self.filterView.frame = CGRectMake(0, filter_y, self_w, filter_h);
}

- (void)setInsetParam:(NSDictionary *)insetParam {
    _insetParam = insetParam;
    self.areaView.insetParam = _insetParam;
    self.sortView.insetParam = _insetParam;
    self.filterView.insetParam = _insetParam;
}

- (IBAction)action:(UIButton *)sender {
    [self changeState:sender];
}

- (void)changeState:(UIButton *)sender {
    if (sender == _currentBtn) {
        if (sender == self.saleBtn) {
            [self.sortView selectFirstItem];
        }else if (sender == self.storeBtn){
            [self.sortView selectFirstItem];
        }else{
            sender.selected = !sender.selected;
        }
    }else{
        _currentBtn.selected = NO;
        sender.selected = YES;
        _currentBtn = sender;
        if (sender == self.saleBtn) {
            [self.sortView selectFirstItem];
        }else if (sender == self.storeBtn){
            [self.sortView selectFirstItem];
        }
    }
    if(!self.isChangingView) [self changeView];
}

- (void)changeView {
    
    self.isChangingView = YES;
    
    UIView *nextShowView = nil;
    if (self.currentBtn.selected) {
        if (self.currentBtn == self.areaBtn) {
            nextShowView = self.areaView;
        }else if (self.currentBtn == self.sortBtn) {
            nextShowView = self.sortView;
        }else if (self.currentBtn == self.filterBtn) {
            nextShowView = self.filterView;
            [self.filterView reset];
        }
    }
    [self hideView:self.currentView completion:^{
        [self showView:nextShowView completion:^{
            CGFloat self_x = CGRectGetMinX(self.frame);
            CGFloat self_y = CGRectGetMinY(self.frame);
            CGFloat self_w = CGRectGetWidth(self.frame);
            CGFloat superView_h = CGRectGetHeight(self.superview.frame);
            CGFloat btnsView_max_y = CGRectGetMaxY(self.btnsView.frame);
            if (nextShowView) {
                self.frame = CGRectMake(self_x, self_y, self_w, superView_h - self_y);
            }else{
                self.frame = CGRectMake(self_x, self_y, self_w, btnsView_max_y);
            }
            [self layoutIfNeeded];
            
            self.isChangingView = NO;
        }];
    }];
}

- (void)hideView:(UIView *)view completion:(void(^)())completion{
    if (!view) {
        if (completion) completion();
    }else{
    
        CGFloat btnsView_max_y = CGRectGetMaxY(self.btnsView.frame);
        CGFloat view_x = view.frame.origin.x;
        CGFloat view_w = view.bounds.size.width;
        CGFloat view_h = view.bounds.size.height;
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.backgroundColor = [UIColor clearColor];
            view.frame = CGRectMake(view_x, btnsView_max_y-view_h, view_w, view_h);
        } completion:^(BOOL finished) {
            if (completion) completion();
        }];
    }
}

- (void)showView:(UIView *)view completion:(void(^)())completion{
    if (!view) {
        if (completion) completion();
    }else{
        CGFloat self_x = CGRectGetMinX(self.frame);
        CGFloat self_y = CGRectGetMinY(self.frame);
        CGFloat self_w = CGRectGetWidth(self.frame);
        CGFloat superView_h = CGRectGetHeight(self.superview.frame);
        CGFloat btnsView_max_y = CGRectGetMaxY(self.btnsView.frame);
        CGFloat view_x = view.frame.origin.x;
        CGFloat view_w = view.bounds.size.width;
        CGFloat view_h = view.bounds.size.height;
        self.frame = CGRectMake(self_x, self_y, self_w, superView_h - self_y);
        view.frame = CGRectMake(view_x, btnsView_max_y-view_h, view_w, view_h);
        [UIView animateWithDuration:kAnimateDuration animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            view.frame = CGRectMake(view_x, btnsView_max_y, view_w, view_h);
        } completion:^(BOOL finished) {
            self.currentView = view;
            if (completion) completion();
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self changeState:self.currentBtn];
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - SearchFactorAreaViewDelegate
- (void)searchFactorAreaView:(SearchFactorAreaView *)view didSelectItem:(SearchFactorAreaDataItem *)item byClick:(BOOL)byClick {
    [self.areaBtn setTitle:item.title forState:UIControlStateNormal];
    self.areaBtn.selected = NO;
    if (byClick) {
        if(!self.isChangingView) [self changeView];
    }
    
}

#pragma mark - SearchFactorSortViewDelegate
- (void)searchFactorSortView:(SearchFactorSortView *)view didSelectItem:(SearchFactorSortDataItem *)item byClick:(BOOL)byClick {
    [self.sortBtn setTitle:item.title forState:UIControlStateNormal];
    self.sortBtn.selected = NO;
    if (byClick) {
        if(!self.isChangingView) [self changeView];
    }
}

#pragma mark - SearchFactorFilterViewDelegate
- (void)searchFactorFilterView:(SearchFactorFilterView *)view didSelectParam:(NSDictionary *)param byClick:(BOOL)byClick {
    self.filterBtn.selected = NO;
    if ([param isKindOfClass:[NSDictionary class]]) {
        self.filterBtnTip.hidden = param.count<1;
    }
    if (byClick) {
        if(!self.isChangingView) [self changeView];
    }
}

@end
