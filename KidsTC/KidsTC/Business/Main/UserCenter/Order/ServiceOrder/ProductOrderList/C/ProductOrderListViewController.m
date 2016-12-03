//
//  ProductOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "YYTimer.h"

#import "ProductOrderListModel.h"
#import "ProductOrderListView.h"

@interface ProductOrderListViewController ()<ProductOrderListViewDelegate>
@property (nonatomic, assign) ProductOrderListType type;
@property (nonatomic, assign) ProductOrderListOrderType orderType;
@property (nonatomic, strong) ProductOrderListView *listView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation ProductOrderListViewController

- (instancetype)initWithType:(ProductOrderListType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.orderType = ProductOrderListOrderTypeAll;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }];
    
    ProductOrderListView *listView = [[ProductOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
    
    self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
}

- (void)countDown{
    [NotificationCenter postNotificationName:kProductOrderListCountDownNoti object:nil];
}


- (void)edit {
    TCLog(@"---");
}

#pragma mark - ProductOrderListViewDelegate

- (void)productOrderListView:(ProductOrderListView *)view actionType:(ProductOrderListViewActionType)type value:(id)value {
    switch (type) {
        case ProductOrderListViewActionTypeLoadData:
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
    NSDictionary *param = @{@"page":@(self.page),
                            @"pageCount":@(ProductOrderListPageCount),
                            @"type":@(self.type),
                            @"orderType":@(self.orderType)};
    [Request startWithName:@"SEARCH_ORDER_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductOrderListModel *model = [ProductOrderListModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.listView.items = self.items;
        [self.listView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.listView dealWithUI:0];
    }];
}

@end
