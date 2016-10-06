//
//  CouponUsableListViewController.m
//  KidsTC
//
//  Created by 钱烨 on 9/7/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "CouponUsableListViewController.h"
#import "WebViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"

static NSString *const kCouponUseRuleUrlString = @"http://m.kidstc.com/tools/coupon_desc";

@interface CouponUsableListViewController () <CouponUsableListViewDataSource, CouponUsableListViewDelegate>

@property (weak, nonatomic) IBOutlet CouponUsableListView *listView;

@property (nonatomic, strong) NSArray *couponModelsArray;

@property (nonatomic, assign) CouponBaseModel *selectedCoupon;

@end

@implementation CouponUsableListViewController

- (instancetype)initWithCouponModels:(NSArray *)modelsArray selectedCoupon:(CouponBaseModel *)coupon {
    self = [super initWithNibName:@"CouponUsableListViewController" bundle:nil];
    if (self) {
        self.couponModelsArray = [modelsArray copy];
        self.selectedCoupon = coupon;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"可用优惠券";
    self.pageId = @"pv_coupons_select";
    // Do any additional setup after loading the view from its nib.
    self.listView.dataSource = self;
    self.listView.delegate = self;
    [self.listView reloadData];
    if (self.selectedCoupon) {
        NSInteger selectedIndex = -1;
        for (NSUInteger index = 0; index < [self.couponModelsArray count]; index ++) {
            CouponFullCutModel *model = [self.couponModelsArray objectAtIndex:index];
            if ([model.couponId isEqualToString:self.selectedCoupon.couponId]) {
                selectedIndex = index;
                break;
            }
        }
        if (selectedIndex >= 0) {
            [self.listView setIndex:selectedIndex selected:YES];
        }
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigation_question" highImageName:@"navigation_question" postion:UIBarButtonPositionRight target:self action:@selector(didClickedCouponRule)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    __weak CouponUsableListViewController *weakSelf = self;
    if (self.dismissBlock) {
        weakSelf.dismissBlock(weakSelf.selectedCoupon);
    }
}

#pragma mark CouponUsableListViewDataSource & CouponUsableListViewDelegate

- (NSArray *)couponModelsOfCouponUsableListView:(CouponUsableListView *)listView {
    return self.couponModelsArray;
}

- (void)couponUsableListView:(CouponUsableListView *)listView didSelectedCouponAtIndex:(NSUInteger)index {
    CouponFullCutModel *model = [self.couponModelsArray objectAtIndex:index];
    NSDictionary *param = [NSDictionary dictionaryWithObject:model.couponId forKey:@"couponcode"];
    [TCProgressHUD showSVP];
    [Request startWithName:@"COUPON_CHECK" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        self.selectedCoupon = [self.couponModelsArray objectAtIndex:index];
        [self back];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        NSString *errMsg = @"该优惠券不可使用";
        if (error.userInfo) {
            NSString *tempErrMsg = [error.userInfo objectForKey:@"data"];
            if ([tempErrMsg isKindOfClass:[NSString class]] && [tempErrMsg length] > 0) {
                errMsg = tempErrMsg;
            }
        }
        [[iToast makeText:errMsg] show];
        [self.listView setIndex:index selected:NO];
    }];
}

- (void)couponUsableListView:(CouponUsableListView *)listView didDeselectedCouponAtIndex:(NSUInteger)index {
    self.selectedCoupon = nil;
}

#pragma mark Private

- (void)didClickedCouponRule {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = kCouponUseRuleUrlString;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
