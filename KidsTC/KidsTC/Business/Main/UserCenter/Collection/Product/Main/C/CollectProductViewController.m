//
//  CollectProductViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductViewController.h"
#import "Colours.h"
#import "MultiItemsToolBar.h"
#import "UIBarButtonItem+Category.h"

#import "CollectProductAllViewController.h"
#import "CollectProductCategoryViewController.h"
#import "CollectProductReduceViewController.h"



@interface CollectProductViewController ()<UIScrollViewDelegate,MultiItemsToolBarDelegate>
@property (nonatomic, strong) MultiItemsToolBar *toolBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *naviRightBtn;

@property (nonatomic, strong) CollectProductAllViewController *allVC;
@property (nonatomic, strong) CollectProductCategoryViewController *categoryVC;
@property (nonatomic, strong) CollectProductReduceViewController *reduceVC;
@end

@implementation CollectProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏服务";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    self.view.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        self.naviRightBtn = btn;
    }];
    
    MultiItemsToolBar *toolBar = [[MultiItemsToolBar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight)];
    toolBar.delegate =  self;
    toolBar.tags = @[@"全部",@"分类",@"降价"];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    CGFloat scrollView_y = CGRectGetMaxY(toolBar.frame);
    CGFloat scrollView_w = SCREEN_WIDTH;
    CGFloat scrollView_h = SCREEN_HEIGHT - scrollView_y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView_y, scrollView_w, scrollView_h)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    //scrollView.scrollEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    _allVC = [[CollectProductAllViewController alloc] init];
    UIView *allView = _allVC.view;
    allView.frame = CGRectMake(0, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:allView];
    [self addChildViewController:_allVC];
    
    _categoryVC = [[CollectProductCategoryViewController alloc] init];
    UIView *categoryView = _categoryVC.view;
    categoryView.frame = CGRectMake(scrollView_w, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:categoryView];
    [self addChildViewController:_categoryVC];
    
    _reduceVC = [[CollectProductReduceViewController alloc] init];
    UIView *reduceView = _reduceVC.view;
    reduceView.frame = CGRectMake(scrollView_w * 2, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:reduceView];
    [self addChildViewController:_reduceVC];
    
    scrollView.contentSize = CGSizeMake(scrollView_w * 3, 1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.toolBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
    });
}

- (void)edit {
    TCLog(@"---");
    self.naviRightBtn.selected = !self.naviRightBtn.selected;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat scrollView_w = CGRectGetWidth(self.scrollView.bounds);
    NSUInteger currentIndex = offsetX/scrollView_w;
    if (currentIndex == 0) {
        _allVC.editing = self.naviRightBtn.selected;
    }else if (currentIndex == 1) {
        
    }else if (currentIndex == 2) {
        _reduceVC.editing = self.naviRightBtn.selected;
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
        self.naviRightBtn.selected = _allVC.editing;
        self.naviRightBtn.hidden = NO;
    }else if (smallIndex == 1) {
        self.naviRightBtn.hidden = YES;
    }else if (smallIndex == 2) {
        self.naviRightBtn.selected = _reduceVC.editing;
        self.naviRightBtn.hidden = NO;
    }
}


@end
