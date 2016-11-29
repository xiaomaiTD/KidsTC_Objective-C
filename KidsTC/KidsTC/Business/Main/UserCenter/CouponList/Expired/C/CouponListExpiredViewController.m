//
//  CouponListExpiredViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListExpiredViewController.h"

#import "GHeader.h"

#import "CouponListExpiredModel.h"
#import "CouponListExpiredView.h"

@interface CouponListExpiredViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListExpiredView *expiredView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CouponListExpiredViewController

- (void)loadView {
    CouponListExpiredView *expiredView = [[CouponListExpiredView alloc] init];
    expiredView.delegate = self;
    self.view =  expiredView;
    self.expiredView = expiredView;
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
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"status":@(CouponListStatusExpired),
                            @"page":@(self.page),
                            @"pagecount":@(CouponListPageCount)};
    [Request startWithName:@"QUERY_USER_COUPON_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CouponListExpiredModel *model = [CouponListExpiredModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.expiredView.items = self.items;
        [self.expiredView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.expiredView dealWithUI:0];
    }];
}



@end
