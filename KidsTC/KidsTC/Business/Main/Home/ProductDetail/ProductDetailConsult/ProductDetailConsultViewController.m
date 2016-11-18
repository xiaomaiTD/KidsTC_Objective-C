//
//  ProductDetailConsultViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailConsultViewController.h"
#import "ProductDetailTwoColumnTableViewConsultCell.h"
#import "GHeader.h"
#import "ProductDetailAddNewConsultViewController.h"
#import "ProductDetailConsultModel.h"
#import "UIBarButtonItem+Category.h"

static NSString *const ID = @"ProductDetailTwoColumnTableViewConsultCell";
static CGFloat const kToolBarH = 49;
static int const pageSize = 10;

@interface ProductDetailConsultViewController ()<UITableViewDelegate,UITableViewDataSource,ProductDetailAddNewConsultViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *items;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ProductDetailConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部咨询";
    
    self.naviTheme = NaviThemeWihte;
    
    [self setupTableView];
    
    [self setupBtn];
}


- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kToolBarH, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [tableView registerNib:[UINib nibWithNibName:@"ProductDetailTwoColumnTableViewConsultCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self setupMJ];
}

- (void)setupMJ{
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadData:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadData:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    [mj_header beginRefreshing];
}


- (void)loadData:(BOOL)refresh {
    _page = refresh?1:++_page;
    NSDictionary *param = @{@"relationNo":self.productId,
                            @"advisoryType":@"1",
                            @"pageIndex":@(_page),
                            @"pageSize":@(pageSize)};
    [Request startWithName:@"GET_ADVISORY_ADN_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailConsultModel *model = [ProductDetailConsultModel modelWithDictionary:dic];
        if (refresh) {
            self.items = [NSArray arrayWithArray:model.items];
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.items];
            self.items = [NSArray arrayWithArray:items];
        }
        [self dealWithUI:model.items.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self dealWithUI:0];
    }];
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<pageSize) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailTwoColumnTableViewConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)setupBtn {
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-kToolBarH, SCREEN_WIDTH, kToolBarH);
    btn.backgroundColor = COLOR_PINK;
    btn.titleLabel.font = [UIFont systemFontOfSize:21];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即提问" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(askAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)askAction:(UIButton *)btn {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductDetailAddNewConsultViewController *controller = [[ProductDetailAddNewConsultViewController alloc] initWithNibName:@"ProductDetailAddNewConsultViewController" bundle:nil];
        controller.productId = self.productId;
        controller.delegate = self;
        controller.consultStr = self.consultStr;
        controller.dellocBlock = ^(NSString *consultStr){
            self.consultStr = consultStr;
        };
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:controller animated:NO completion:nil];
    }];
}

#pragma mark ProductDetailAddNewConsultViewControllerDelegate

- (void)productDetailAddNewConsultViewController:(ProductDetailAddNewConsultViewController *)controller actionType:(ProductDetailAddNewConsultViewControllerActionType)type value:(id)value {
    switch (type) {
        case ProductDetailAddNewConsultViewControllerActionTypeReload:
        {
            [self.tableView.mj_header beginRefreshing];
        }
            break;
    }
}

@end
