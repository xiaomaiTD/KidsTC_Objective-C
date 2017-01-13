//
//  ActivityProductViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductViewController.h"
#import "GHeader.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"

#import "ActivityProductModel.h"
#import "ActivityProductView.h"

@interface ActivityProductViewController ()<ActivityProductViewDelegate>
@property (nonatomic, strong) ActivityProductView *productView;
@property (nonatomic, strong) ActivityProductData *data;
@end

@implementation ActivityProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ID = @"E7-92-F0-91-75-A7-E1-ED_50";
    
    if (![_ID isNotNull]) {
        [[iToast makeText:@"活动编号为空"] show];
        [self back];
        return;
    }
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"服务活动";
    
    ActivityProductView *productView = [[ActivityProductView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    productView.delegate = self;
    [self.view addSubview:productView];
    self.productView = productView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    
    [self loadData];
}

- (void)share {
    
}

- (void)loadData {
    NSDictionary *param = @{@"id":_ID};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_EVENT_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ActivityProductData *data = [ActivityProductModel modelWithDictionary:dic].data;
        if (data.showFloorItems.count>0) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(ActivityProductData *)data {
    self.data = data;
    self.productView.data = data;
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"获取活动信息失败，请稍后再试！"] show];
    [self back];
}

#pragma mark - ActivityProductViewDelegate

- (void)activityProductView:(ActivityProductView *)view actionType:(ActivityProductViewActionType)type value:(id)value {
    
}

@end
