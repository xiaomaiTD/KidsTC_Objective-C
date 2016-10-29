//
//  CouponListViewController.m
//  KidsTC
//
//  Created by 钱烨 on 9/6/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "CouponListViewController.h"
#import "WebViewController.h"
#import "CouponUsableServiceViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
static NSString *const kCouponUseRuleUrlString = @"http://m.kidstc.com/tools/coupon_desc";

@interface CouponListViewController () <CouponListViewDelegate>
@property (weak, nonatomic) IBOutlet CouponListView *listView;
@property (nonatomic, strong) CouponListViewModel *viewModel;
@property (nonatomic, assign) CouponListViewTag firstLoadViewTag;
@end

@implementation CouponListViewController

- (instancetype)initWithCouponListViewTag:(CouponListViewTag)tag {
    self = [super initWithNibName:@"CouponListViewController" bundle:nil];
    if (self) {
        self.firstLoadViewTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.listView.delegate = self;
    self.viewModel = [[CouponListViewModel alloc] initWithView:self.listView];
    [self.listView setViewTag:self.firstLoadViewTag];
    [self.viewModel startUpdateDataWithViewTag:self.firstLoadViewTag];
    [self.listView reloadSegmentHeader];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigation_question" highImageName:@"navigation_question" postion:UIBarButtonPositionRight target:self action:@selector(didClickedCouponRule)];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TCProgressHUD dismissSVP];
}

#pragma mark CouponListViewDelegate

- (void)couponListView:(CouponListView *)listView willShowWithTag:(CouponListViewTag)tag {
    [self.viewModel resetResultWithViewTag:tag];
}

- (void)couponListView:(CouponListView *)listView DidPullDownToRefreshforViewTag:(CouponListViewTag)tag {
    [self.viewModel startUpdateDataWithViewTag:tag];
}

- (void)couponListView:(CouponListView *)listView DidPullUpToLoadMoreforViewTag:(CouponListViewTag)tag {
    [self.viewModel getMoreDataWithViewTag:tag];
}

- (void)couponListView:(CouponListView *)listView didSelectedAtIndex:(NSUInteger)index ofViewTag:(CouponListViewTag)tag {
    NSArray *coupons = [self.viewModel resultOfCurrentViewTag];
    if ([coupons count] > index) {
        CouponFullCutModel *model = [coupons objectAtIndex:index];
        if (model.hasRelatedService) {
            CouponUsableServiceViewController *controller = [[CouponUsableServiceViewController alloc] initWithCouponBatchIdentifier:model.batchId];
            [controller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark Private

- (void)didClickedCouponRule {

    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = kCouponUseRuleUrlString;
    [self.navigationController pushViewController:controller animated:YES];

}


@end
