//
//  ParentingStrategyViewController.m
//  KidsTC
//
//  Created by 钱烨 on 7/8/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ParentingStrategyViewController.h"
#import "ParentingStrategyViewModel.h"
#import "ParentingStrategyDetailViewController.h"
#import "TCProgressHUD.h"

@interface ParentingStrategyViewController () <ParentingStrategyViewDelegate ,ParentingStrategyFilterViewDelegate>

@property (weak, nonatomic) IBOutlet ParentingStrategyView *strategyView;

@property (nonatomic, strong) ParentingStrategyFilterView *filterView;

@property (nonatomic, strong) ParentingStrategyViewModel *viewModel;

- (void)didClickedFilterButton;

@end

@implementation ParentingStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"亲子攻略";
    self.pageId = @"pv_stgys";
    // Do any additional setup after loading the view from its nib.
    self.strategyView.delegate = self;
    
    //[self setupRightBarButton:nil target:self action:@selector(didClickedFilterButton) frontImage:@"navigation_sort" andBackImage:@"navigation_sort"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 22, 22)];
    [btn setImage:[UIImage imageNamed:@"navigation_sort"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [btn addTarget:self action:@selector(didClickedFilterButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    self.filterView = [[ParentingStrategyFilterView alloc] init];
    self.filterView.delegate = self;
    
    self.viewModel = [[ParentingStrategyViewModel alloc] initWithView:self.strategyView];
    [self.strategyView startRefresh];
}

#pragma mark ParentingStrategyViewDelegate

- (void)didPullDownToRefreshForParentingStrategyView:(ParentingStrategyView *)strategyView {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)didPullUpToLoadMoreForParentingStrategyView:(ParentingStrategyView *)strategyView {
    [self.viewModel getMoreStrategies];
}

- (void)parentingStrategyView:(ParentingStrategyView *)strategyView didSelectedItemAtIndex:(NSUInteger)index {
    ParentingStrategyListItemModel *model = [[self.viewModel resutlStrategies] objectAtIndex:index];
    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.identifier];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ParentingStrategyFilterViewDelegate

- (void)didClickedConfirmButtonOnParentingStrategyFilterView:(ParentingStrategyFilterView *)filterView withSelectedSortType:(ParentingStrategySortType)type selectedAreaIndex:(NSUInteger)index {
    if (self.viewModel.currentSortType != type/* || self.viewModel.currentAreaIndex != index*/) {
        [self.viewModel setCurrentSortType:type];
        [self.viewModel setCurrentAreaIndex:index];
        [TCProgressHUD showSVP];
        [self.viewModel startUpdateDataWithSucceed:^(NSDictionary *data) {
            [TCProgressHUD dismissSVP];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
        }];
    }
}

#pragma mark Private methods

- (void)didClickedFilterButton {
    [self.filterView showWithSelectedSortType:self.viewModel.currentSortType selectedAreaIndex:self.viewModel.currentAreaIndex];
}


@end
