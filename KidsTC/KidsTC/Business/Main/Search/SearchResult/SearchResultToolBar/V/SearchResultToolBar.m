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
#import "Colours.h"

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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineWOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineWTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineWThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineWFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineHOne;

@property (nonatomic, strong) SearchFactorAreaView *areaView;
@property (nonatomic, strong) SearchFactorSortView *sortView;
@property (nonatomic, strong) SearchFactorFilterView *filterView;

@property (nonatomic, weak) UIView *currentView;
@property (nonatomic, weak) UIButton *lastClickedBtn;
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
    
    self.VLineWOne.constant = LINE_H;
    self.VLineWTwo.constant = LINE_H;
    self.VLineWThree.constant = LINE_H;
    self.VLineWFour.constant = LINE_H;
    self.HLineHOne.constant = LINE_H;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat view_y = CGRectGetMaxY(self.btnsView.frame);
    
    CGFloat area_h = self.areaView.contentHeight;
    CGFloat area_y = (self.currentView == self.areaView)?view_y:(view_y - area_h);
    self.areaView.frame = CGRectMake(0, area_y, self_w, area_h);
    
    CGFloat sort_h = self.sortView.contentHeight;
    CGFloat sort_y = (self.currentView == self.sortView)?view_y:(view_y - sort_h);
    self.sortView.frame = CGRectMake(0, sort_y, self_w, sort_h);
    
    CGFloat filter_h = self.filterView.contentHeight;
    CGFloat filter_y = (self.currentView == self.filterView)?view_y:(view_y - filter_h);
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
    
    if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
        [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeBtnClicked value:nil];
    }
    
    UIView *nextShowView = nil;
    if (sender == self.areaBtn) {
        nextShowView = self.areaView;
        self.areaBtn.selected   = !self.areaBtn.selected;
        self.sortBtn.selected = NO;
        self.filterBtn.selected = NO;
        
    }else if (sender == self.sortBtn) {
        nextShowView = self.sortView;
        
        self.areaBtn.selected   = NO;
        self.sortBtn.selected   = !self.sortBtn.selected;
        self.filterBtn.selected = NO;
        
    }else if (sender == self.saleBtn) {
        
        if (sender == self.lastClickedBtn) return;
        
        self.areaBtn.selected   = NO;
        self.sortBtn.selected   = NO;
        [self.sortBtn setTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
        [self.sortBtn setImage:[UIImage imageNamed:@"search_toolBar_btnTip_down"] forState:UIControlStateNormal];
        self.saleBtn.selected   = YES;
        self.storeBtn.selected  = NO;
        self.filterBtn.selected = NO;
        
        [self.sortView selectFirstItem];
        
        if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
            [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeDidSelectProduct value:nil];
        }
        
        [self setParamValue:@"8" key:kSearchKey_sort];
        
    }else if (sender == self.storeBtn) {
        
        if (sender == self.lastClickedBtn) return;
        
        self.areaBtn.selected   = NO;
        self.sortBtn.selected   = NO;
        [self.sortBtn setTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
        [self.sortBtn setImage:[UIImage imageNamed:@"search_toolBar_btnTip_down"] forState:UIControlStateNormal];
        self.saleBtn.selected   = NO;
        self.storeBtn.selected  = YES;
        self.filterBtn.selected = NO;
        
        [self.sortView selectFirstItem];
        
        if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
            [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeDidSeltctStore value:nil];
        }
        
    }else if (sender == self.filterBtn) {
        nextShowView = self.filterView;
        
        self.areaBtn.selected   = NO;
        self.sortBtn.selected = NO;
        self.filterBtn.selected = !self.filterBtn.selected;
    }
    
    self.lastClickedBtn = sender;
    
    if(!self.isChangingView) [self changeView];
}

- (void)changeView {
    
    self.isChangingView = YES;
    UIView *nextShowView = self.nextShowView;
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

- (UIView *)nextShowView {
    UIView *nextShowView = nil;
    if (self.lastClickedBtn.selected) {
        if (self.lastClickedBtn == self.areaBtn) {
            nextShowView = self.areaView;
        }else if (self.lastClickedBtn == self.sortBtn) {
            nextShowView = self.sortView;
        }else if (self.lastClickedBtn == self.filterBtn) {
            nextShowView = self.filterView;
            [self.filterView reset];
        }
    }
    return nextShowView;
}

- (void)hideView:(UIView *)view completion:(void(^)())completion{
    if (!view) {
        if (completion) completion();
    }else{
        self.currentView = nil;
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
        self.currentView = view;
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
            if (completion) completion();
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self changeState:self.lastClickedBtn];
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
        [self setParamValue:item.value key:kSearchKey_area];
    }
}

#pragma mark - SearchFactorSortViewDelegate
- (void)searchFactorSortView:(SearchFactorSortView *)view didSelectItem:(SearchFactorSortDataItem *)item byClick:(BOOL)byClick {
    [self.sortBtn setTitle:item.title forState:UIControlStateNormal];
    self.sortBtn.selected = NO;
    if (byClick) {
        
        if (self.searchType != SearchTypeProduct) {
            self.searchType = SearchTypeProduct;
            if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
                [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeDidSelectProduct value:nil];
            }
        }
        
        self.saleBtn.selected   = NO;
        self.storeBtn.selected  = NO;
        [self.sortBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
        [self.sortBtn setImage:[UIImage imageNamed:@"search_toolBar_btnTip_down_red"] forState:UIControlStateNormal];
        if(!self.isChangingView) [self changeView];
        [self setParamValue:item.value key:kSearchKey_sort];
    }
}

#pragma mark - SearchFactorFilterViewDelegate
- (void)searchFactorFilterView:(SearchFactorFilterView *)view didSelectParam:(NSDictionary *)param byClick:(BOOL)byClick {
    self.filterBtn.selected = NO;
    if ([param isKindOfClass:[NSDictionary class]]) {
        __block BOOL show = NO;
        [param.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *str = [NSString stringWithFormat:@"%@",obj];
            if ([str isNotNull]) {
                show = YES;
                *stop = YES;
            }
        }];
        self.filterBtnTip.hidden = !show;
    }
    if (byClick) {
        if(!self.isChangingView) [self changeView];
        [self setNewParam:param];
    }
}

#pragma mark - helpers 

- (void)setParamValue:(NSString *)value key:(NSString *)key {
    NSString *valueStr = [NSString stringWithFormat:@"%@",value];
    NSMutableDictionary *insetParam = [NSMutableDictionary dictionaryWithDictionary:_insetParam];
    [insetParam setObject:valueStr forKey:key];
    _insetParam = [NSDictionary dictionaryWithDictionary:insetParam];
    if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
        [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeDidSelectParam value:_insetParam];
    }
}

- (void)setNewParam:(NSDictionary *)newparam {
    if (newparam.count>0) {
        NSMutableDictionary *insetParam = [NSMutableDictionary dictionaryWithDictionary:_insetParam];
        [insetParam setDictionary:newparam];
        _insetParam = [NSDictionary dictionaryWithDictionary:insetParam];
        if ([self.delegate respondsToSelector:@selector(searchResultToolBar:actionType:value:)]) {
            [self.delegate searchResultToolBar:self actionType:SearchResultToolBarActionTypeDidSelectParam value:_insetParam];
        }
    }
}

@end
