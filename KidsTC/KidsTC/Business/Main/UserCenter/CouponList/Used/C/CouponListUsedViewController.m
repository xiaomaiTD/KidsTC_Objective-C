//
//  CouponListUsedViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUsedViewController.h"

#import "GHeader.h"

#import "CouponListUsedModel.h"
#import "CouponListUsedView.h"

@interface CouponListUsedViewController ()<CouponListBaseViewDelegate>
@property (nonatomic, strong) CouponListUsedView *usedView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CouponListUsedViewController

- (void)loadView {
    CouponListUsedView *usedView = [[CouponListUsedView alloc] init];
    usedView.delegate = self;
    self.view =  usedView;
    self.usedView = usedView;
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
    NSDictionary *param = @{@"status":@(CouponListStatusUsed),
                            @"page":@(self.page),
                            @"pagecount":@(CouponListPageCount)};
    [Request startWithName:@"QUERY_USER_COUPON_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        CouponListUsedModel *model = [CouponListUsedModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.usedView.items = self.items;
        [self.usedView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.usedView dealWithUI:0];
    }];
}

@end
