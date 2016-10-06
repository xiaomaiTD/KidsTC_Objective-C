//
//  SettlementPickStoreViewController.m
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementPickStoreViewController.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "SettlementPickStoreModel.h"
#import "SettlementPickStoreViewCell.h"
#import "NSString+Category.h"

#define ITEM_MARGIN 12

@interface SettlementPickStoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) SettlementPickStoreModel *model;
@end
static NSString *const ID = @"SettlementPickStoreViewCellID";
@implementation SettlementPickStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择门店";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ITEM_MARGIN)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"SettlementPickStoreViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadData];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
    [mj_header beginRefreshing];
}

- (void)loadData{
    
    NSString *mapaddr = [KTCMapService shareKTCMapService].currentLocationString;
    NSString *serveId = [self.serveId isNotNull]?self.serveId:@"";
    NSString *channelId = [self.channelId isNotNull]?self.channelId:@"0";
    NSDictionary *param = @{@"pid":serveId,
                            @"chid":channelId,
                            @"mapaddr":mapaddr};
    [Request startWithName:@"PRODUCT_STORE_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccess:[SettlementPickStoreModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadDataSuccess:(SettlementPickStoreModel *)model {
    [self setSelectedStoreId:self.storeId model:model];
    self.model = model;
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettlementPickStoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.model.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettlementPickStoreDataItem *store = self.model.data[indexPath.row];
    [self setSelectedStoreId:store.storeId model:self.model];
    [tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self back];
        if (self.pickStoreBlock) self.pickStoreBlock(store);
    });
}

#pragma mark - helpers

- (void)setSelectedStoreId:(NSString *)storeId model:(SettlementPickStoreModel *)model {
    [model.data enumerateObjectsUsingBlock:^(SettlementPickStoreDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = [obj.storeId isEqualToString:storeId];
    }];
}

@end
