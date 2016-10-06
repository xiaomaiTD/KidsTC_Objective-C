//
//  UserAddressManageViewController.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressManageViewController.h"
#import "UserAddressManageViewCell.h"
#import "GHeader.h"
#import "UserAddressEditViewController.h"
#import "KTCEmptyDataView.h"

#define ADDBTN_BOTTOM_MARGIN 20
#define ADDBTN_SIZE 60

@interface UserAddressManageViewController ()<UITableViewDelegate,UITableViewDataSource,UserAddressManageViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<UserAddressManageDataItem *> *data;
@end

static NSString *const ID = @"UserAddressManageViewCellID";

@implementation UserAddressManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"UserAddressManageViewCell" bundle:nil] forCellReuseIdentifier:ID];
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadData];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
    
    [tableView.mj_header beginRefreshing];
    
    CGFloat addBtnX = (SCREEN_WIDTH-ADDBTN_SIZE)*0.5;
    CGFloat addBtnY = SCREEN_HEIGHT-ADDBTN_SIZE-ADDBTN_BOTTOM_MARGIN;
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(addBtnX, addBtnY, ADDBTN_SIZE, ADDBTN_SIZE)];
    [addBtn setImage:[UIImage imageNamed:@"addressManage_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)loadData{
    [Request startWithName:@"ADDRESS_USER_GET_LIST" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        UserAddressManageModel *model = [UserAddressManageModel modelWithDictionary:dic];
        self.data = model.data;
        [self dealiWithInterface];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self dealiWithInterface];
    }];
}

- (void)addAddress{
    UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
    controller.editType = UserAddressEditTypeAdd;
    controller.resultBlock = ^void(UserAddressManageDataItem *item){
        [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dealiWithInterface {
    [self.tableView.mj_header endRefreshing];
    if (self.data.count<=0) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
    }else{
        self.tableView.backgroundView = nil;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UserAddressManageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate  = self;
    cell.fromeType = self.fromeType;
    cell.item      = self.data[indexPath.section];
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.fromeType == UserAddressManageFromTypeSettlement) {
        if(self.pickeAddressBlock)self.pickeAddressBlock(self.data[indexPath.section]);
        [self back];
    }
}

#pragma mark - UserAddressManageViewCellDelegate

- (void)userAddressManageViewCell:(UserAddressManageViewCell *)cell actionType:(UserAddressManageViewCellActionType)type{
    UserAddressManageDataItem *item = cell.item;
    switch (type) {
        case UserAddressManageViewCellActionTypeEdit:
        {
            UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
            controller.editType = UserAddressEditTypeModify;
            controller.model = [UserAddressEditModel modelWith:item];
            controller.resultBlock = ^void (UserAddressManageDataItem *item){
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case UserAddressManageViewCellActionTypeDelet:
        {
            UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:@"是否确认删除地址？" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *delect = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *param = @{@"id":item.ID};
                [TCProgressHUD showSVP];
                [Request startWithName:@"ADDRESS_USER_DEL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                    [TCProgressHUD dismissSVP];
                    [[iToast makeText:@"删除成功"] show];
                    NSMutableArray<UserAddressManageDataItem *> *data = [NSMutableArray arrayWithArray:self.data];
                    [data removeObjectAtIndex:cell.indexPath.section];
                    self.data = data;
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [TCProgressHUD dismissSVP];
                    [[iToast makeText:@"删除失败"] show];
                }];
            }];
            [sheet addAction:cancle];
            [sheet addAction:delect];
            [self presentViewController:sheet animated:YES completion:nil];
        }
            break;
    }
}



@end
