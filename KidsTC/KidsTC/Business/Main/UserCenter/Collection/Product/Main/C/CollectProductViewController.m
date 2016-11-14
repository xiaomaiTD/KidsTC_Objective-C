//
//  CollectProductViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductViewController.h"

#import "MultiItemsToolBar.h"
#import "UIBarButtonItem+Category.h"

#import "CollectProductAllViewController.h"
#import "CollectProductCategoryViewController.h"
#import "CollectProductReduceViewController.h"



@interface CollectProductViewController ()<UIScrollViewDelegate,MultiItemsToolBarDelegate>
@property (nonatomic, strong) MultiItemsToolBar *toolBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *naviRightBtn;
@end

@implementation CollectProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏服务";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
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
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *allView = [[CollectProductAllViewController alloc] init].view;
    allView.frame = CGRectMake(0, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:allView];
    
    UIView *categoryView = [[CollectProductCategoryViewController alloc] init].view;
    categoryView.frame = CGRectMake(scrollView_w, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:categoryView];
    
    UIView *reduceView = [[CollectProductReduceViewController alloc] init].view;
    reduceView.frame = CGRectMake(scrollView_w * 2, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:reduceView];
    
    scrollView.contentSize = CGSizeMake(scrollView_w * 3, 1);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.toolBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
}

- (void)edit {
    TCLog(@"---");
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
}


@end
