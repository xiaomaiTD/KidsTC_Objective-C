//
//  ProductOrderFreeDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"

#import "ProductOrderFreeDetailModel.h"
#import "ProductOrderFreeDetailLotteryModel.h"
#import "ProductOrderFreeDetailView.h"

@interface ProductOrderFreeDetailViewController ()<ProductOrderFreeDetailViewDelegate>
@property (nonatomic, strong) ProductOrderFreeDetailView *detailView;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
@property (nonatomic, strong) ProductOrderFreeDetailLotteryData *lotteryData;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ProductOrderFreeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"报名详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    ProductOrderFreeDetailView *detailView = [[ProductOrderFreeDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    [self loadData];
    
}

#pragma mark - ProductOrderFreeDetailViewDelegate

- (void)productOrderFreeDetailView:(ProductOrderFreeDetailView *)view
                        actionType:(ProductOrderFreeDetailViewActionType)type
                             value:(id)value
{
    switch (type) {
            
        default:
            break;
    }
}

- (void)loadData {
    if (![_orderId isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"orderId":_orderId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_USER_ENROLL_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductOrderFreeDetailData *data = [ProductOrderFreeDetailModel modelWithDictionary:dic].data;
        if (data) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:nil];
    }];
}

- (void)loadDataSuccess:(ProductOrderFreeDetailData *)data {
    self.infoData = data;
    self.detailView.infoData = data;
    [self.detailView reloadInfoData];
    if (data.freeType == ProductOrderFreeListTypeLottery) {
        [self loadLottery];
    }
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"获取报名详情失败"] show];
    [self back];
}

//获取中奖名单
- (void)loadLottery {
    if (![_orderId isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"page":@(++self.page),
                            @"pageCount":@(TCPAGECOUNT),
                            @"orderId":_orderId};
    [Request startWithName:@"GET_ENROLL_PRIZE_PAGE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductOrderFreeDetailLotteryModel *model = [ProductOrderFreeDetailLotteryModel modelWithDictionary:dic];
        self.lotteryData = model.data;
        self.detailView.lotteryData = self.lotteryData;
        [self.detailView reloadLotteryData];
    } failure:nil];
}

@end
