//
//  CouponListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListViewController.h"
#import "MultiItemsToolBar.h"
#import "UIBarButtonItem+Category.h"

#import "CouponListUnusedViewController.h"
#import "CouponListUsedViewController.h"
#import "CouponListExpiredViewController.h"

@interface CouponListViewController ()<UIScrollViewDelegate,MultiItemsToolBarDelegate>
@property (nonatomic, strong) MultiItemsToolBar *toolBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *naviRightBtn;

@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"优惠券";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    MultiItemsToolBar *toolBar = [[MultiItemsToolBar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight)];
    toolBar.delegate =  self;
    toolBar.tags = @[@"未使用",@"已使用",@"已过期"];
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
    
    UIView *allView = [[CouponListUnusedViewController alloc] init].view;
    allView.frame = CGRectMake(0, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:allView];
    
    UIView *categoryView = [[CouponListUsedViewController alloc] init].view;
    categoryView.frame = CGRectMake(scrollView_w, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:categoryView];
    
    UIView *reduceView = [[CouponListExpiredViewController alloc] init].view;
    reduceView.frame = CGRectMake(scrollView_w * 2, 0, scrollView_w, scrollView_h);
    [scrollView addSubview:reduceView];
    
    scrollView.contentSize = CGSizeMake(scrollView_w * 3, 1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.toolBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
    });
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
