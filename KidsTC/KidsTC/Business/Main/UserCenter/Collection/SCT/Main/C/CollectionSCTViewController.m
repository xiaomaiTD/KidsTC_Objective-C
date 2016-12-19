//
//  CollectionSCTViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionSCTViewController.h"

#import "MultiItemsToolBar.h"
#import "UIBarButtonItem+Category.h"
#import "Colours.h"

#import "CollectionStoreViewController.h"
#import "CollectionContentViewController.h"
#import "CollectionTarentoViewController.h"

@interface CollectionSCTViewController ()<UIScrollViewDelegate,MultiItemsToolBarDelegate>
@property (nonatomic, strong) MultiItemsToolBar *toolBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *naviRightBtn;
@property (nonatomic, strong) CollectionStoreViewController *storeVC;
@property (nonatomic, strong) CollectionContentViewController *contentVC;
@property (nonatomic, strong) CollectionTarentoViewController *tarentoVC;
@end

@implementation CollectionSCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        self.naviRightBtn = btn;
    }];
    
    MultiItemsToolBar *toolBar = [[MultiItemsToolBar alloc] initWithFrame:CGRectMake(0, 0, 200, MultiItemsToolBarScrollViewHeight)];
    toolBar.delegate =  self;
    toolBar.tags = @[@"门店",@"内容",@"达人"];
    toolBar.backgroundColor = [UIColor clearColor];
    toolBar.scrollView.backgroundColor = [UIColor clearColor];
    toolBar.line.backgroundColor = [UIColor clearColor];
    toolBar.leftLayer.backgroundColor = [UIColor clearColor].CGColor;
    toolBar.rightLayer.backgroundColor = [UIColor clearColor].CGColor;
    toolBar.leftLayer.colors = nil;
    toolBar.rightLayer.colors = nil;
    self.navigationItem.titleView = toolBar;
    self.toolBar = toolBar;
    
    
    CGFloat scrollView_y = 64;
    CGFloat scrollView_w = SCREEN_WIDTH;
    CGFloat scrollView_h = SCREEN_HEIGHT - scrollView_y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView_y, scrollView_w, scrollView_h)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    _storeVC = [[CollectionStoreViewController alloc] init];
    UIView *allView = _storeVC.view;
    allView.frame = CGRectMake(0, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:allView];
    [self addChildViewController:_storeVC];
    
    _contentVC = [[CollectionContentViewController alloc] init];
    UIView *categoryView = _contentVC.view;
    categoryView.frame = CGRectMake(scrollView_w, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:categoryView];
    [self addChildViewController:_contentVC];
    
    _tarentoVC = [[CollectionTarentoViewController alloc] init];
    UIView *reduceView = _tarentoVC.view;
    reduceView.frame = CGRectMake(scrollView_w * 2, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:reduceView];
    [self addChildViewController:_tarentoVC];
    
    scrollView.contentSize = CGSizeMake(scrollView_w * 3, 1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentOffset = CGPointMake(((int)_type) * scrollView_w, 0);
        [self scrollViewDidScroll:self.scrollView];
    });
}

- (void)edit {
    self.naviRightBtn.selected = !self.naviRightBtn.selected;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat scrollView_w = CGRectGetWidth(self.scrollView.bounds);
    NSUInteger currentIndex = offsetX/scrollView_w;
    if (currentIndex == 0) {
        _storeVC.editing = self.naviRightBtn.selected;
    }else if (currentIndex == 1) {
        _contentVC.editing = self.naviRightBtn.selected;
    }else if (currentIndex == 2) {
        _tarentoVC.editing = self.naviRightBtn.selected;
    }
}

#pragma mark - MultiItemsToolBarDelegate

- (void)multiItemsToolBar:(MultiItemsToolBar *)multiItemsToolBar didSelectedIndex:(NSUInteger)index {
    CGFloat scrollView_w = CGRectGetWidth(self.scrollView.bounds);
    self.scrollView.contentOffset = CGPointMake(scrollView_w*index, 0);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollView_w = CGRectGetWidth(self.scrollView.bounds);
    NSUInteger smallIndex = offsetX/scrollView_w;
    NSUInteger bigIndex = smallIndex+1;
    CGFloat progress = (offsetX - smallIndex * scrollView_w)/scrollView_w;
    
    [self.toolBar changeTipPlaceWithSmallIndex:smallIndex bigIndex:bigIndex progress:progress animate:YES];
    
    if (smallIndex == 0) {
        self.naviRightBtn.selected = _storeVC.editing;
    }else if (smallIndex == 1) {
        self.naviRightBtn.selected = _contentVC.editing;
    }else if (smallIndex == 2) {
        self.naviRightBtn.selected = _tarentoVC.editing;
    }
}

@end
