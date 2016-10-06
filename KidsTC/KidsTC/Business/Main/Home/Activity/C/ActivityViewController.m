//
//  ActivityViewController.m
//  KidsTC
//
//  Created by 钱烨 on 10/12/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewModel.h"
#import "ServiceDetailViewController.h"
#import "ActivityFilterView.h"

#import "UIBarButtonItem+Category.h"
#import "TCProgressHUD.h"

@interface ActivityViewController () <ActivityViewDelegate, ActivityFilterViewDelegate>

@property (weak, nonatomic) IBOutlet ActivityView *activityView;

@property (nonatomic, strong) ActivityViewModel *viewModel;

@property (nonatomic, strong) ActivityFilterView *filterView;

@property (nonatomic, assign) NSInteger currentCategoryIndex;

@property (nonatomic, strong) ActivityFilterModel *filterModel;

@property (nonatomic, assign) NSInteger currentAreaIndex;

- (void)didClickedFilterButton;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热门活动";
    self.currentCategoryIndex = INVALID_INDEX;
    self.currentAreaIndex = INVALID_INDEX;
    
    self.activityView.delegate = self;
    
    self.viewModel = [[ActivityViewModel alloc] initWithView:self.activityView];
    [self.activityView startRefresh];
    
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"navigation_filter" highImageName:@"navigation_filter" postion:UIBarButtonPositionRight target:self action:@selector(didClickedFilterButton)];
}


#pragma mark ActivityViewDelegate

- (void)didPullDownToRefreshForActivityView:(ActivityView *)view {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)didPullUpToLoadMoreForactivityView:(ActivityView *)view {
    [self.viewModel getMoreDataWithSucceed:nil failure:nil];
}

- (void)activityView:(ActivityView *)view didSelectedItemAtIndex:(NSUInteger)index {
    ActivityListItemModel *itemModel = [[self.viewModel resultArray] objectAtIndex:index];
    
    ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:itemModel.activityId channelId:itemModel.channelId];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ActivityFilterViewDelegate

- (void)didClickedConfirmButtonOnActivityFilterView:(ActivityFilterView *)filterView withSelectedCategoryIndex:(NSUInteger)categoryIndex selectedAreaIndex:(NSUInteger)areaIndex {
    if (categoryIndex == self.currentCategoryIndex && areaIndex == self.currentAreaIndex) {
        return;
    }
    if ([self.filterModel.categoryFiltItems count] > categoryIndex) {
        self.viewModel.currentCategoryItem = [self.filterModel.categoryFiltItems objectAtIndex:categoryIndex];
    }
    if ([self.filterModel.areaFiltItems count] > areaIndex) {
        self.viewModel.currentAreaItem = [self.filterModel.areaFiltItems objectAtIndex:areaIndex];
    }
    
    [TCProgressHUD showInView:self.view];
    [self.viewModel startUpdateDataWithSucceed:^(NSDictionary *data) {
        [TCProgressHUD dismiss];
    } failure:^(NSError *error) {
        [TCProgressHUD dismiss];
    }];
}

#pragma mark Private methods

- (void)didClickedFilterButton {
    
    if (!self.filterView) {
        self.filterView = [[ActivityFilterView alloc] init];
        self.filterView.delegate = self;
    }
    if (!self.filterModel || [self.filterModel needRefresh]) {
        __weak ActivityViewController *weakSelf = self;
        [self.filterView showLoading:YES];
        [weakSelf.viewModel getCategoryDataWithSucceed:^(NSDictionary *data) {
            
            weakSelf.filterModel = [[ActivityFilterModel alloc] initWithRawData:[data objectForKey:@"data"]];
            if (weakSelf.filterModel) {
                [weakSelf.filterView setCategoryNameArray:[weakSelf.filterModel categotyNames]];
                [weakSelf.filterView setAreaNameArray:[weakSelf.filterModel areaNames]];
            }
            [weakSelf.filterView showLoading:NO];
        } failure:^(NSError *error) {
            
            [weakSelf.filterView showLoading:NO];
        }];
    }
    [self.filterView showWithSelectedCategoryIndex:self.currentAreaIndex selectedAreaIndex:self.currentAreaIndex];
}


@end
