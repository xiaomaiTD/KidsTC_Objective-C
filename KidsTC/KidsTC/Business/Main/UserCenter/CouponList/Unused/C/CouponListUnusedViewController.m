
//
//  CouponListUnusedViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedViewController.h"

#import "GHeader.h"

#import "CouponListUnusedModel.h"
#import "CouponListUnusedView.h"

#import "CouponUsableServiceViewController.h"

@interface CouponListUnusedViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListUnusedView *unusedView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CouponListUnusedViewController

- (void)loadView {
    CouponListUnusedView *unusedView = [[CouponListUnusedView alloc] init];
    unusedView.delegate = self;
    self.view =  unusedView;
    self.unusedView = unusedView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
}

#pragma mark - CollectProductBaseViewActionTypeDelegate

- (void)couponListBaseView:(CouponListBaseView *)view actionType:(CouponListBaseViewActionType)type value:(id)value {
    switch (type) {
        case CouponListBaseViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        case CouponListBaseViewActionTypeUseCoupon:
        {
            CouponUsableServiceViewController *controller = [[CouponUsableServiceViewController alloc] initWithCouponBatchIdentifier:value];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"status":@(CouponListStatusUnused),
                            @"page":@(self.page),
                            @"pagecount":@(CouponListPageCount)};
    [Request startWithName:@"QUERY_USER_COUPON_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CouponListUnusedModel *model = [CouponListUnusedModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.unusedView.items = self.items;
        [self.unusedView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.unusedView dealWithUI:0];
    }];
}



@end
