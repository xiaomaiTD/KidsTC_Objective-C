//
//  TCHomeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeViewController.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "TCHomeModel.h"
#import "TCHomeBaseTableViewCell.h"

static NSString *const kTCHomeBaseTableViewCellID = @"TCHomeBaseTableViewCell";

@interface TCHomeViewController ()<UITableViewDelegate,UITableViewDataSource,TCHomeBaseTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TCHomeData *data;
@end

@implementation TCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[TCHomeBaseTableViewCell class] forCellReuseIdentifier:kTCHomeBaseTableViewCellID];
    self.tableView = tableView;
}

- (void)loadData {
    
    NSString *type = [User shareUser].role.roleIdentifierString;
    NSDictionary *param = @{@"type":@"13",@"category":@""};
    
    [Request startWithName:@"GET_PAGE_HOME_NEW_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCHomeModel *model = [TCHomeModel modelWithDictionary:dic];
        self.data = model.data;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<self.data.sections.count) {
        return self.data.sections[indexPath.section].floorHeight;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section<self.data.sections.count) {
        return self.data.sections[section].marginTop;
    }else{
        return 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCHomeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTCHomeBaseTableViewCellID];
    cell.delegate = self;
    if (indexPath.section<self.data.sections.count) {
        cell.floor = self.data.sections[indexPath.section];
    }
    return cell;
}

#pragma mark - TCHomeBaseTableViewCellDelegate

- (void)tcHomeBaseTableViewCell:(TCHomeBaseTableViewCell *)cell actionType:(TCHomeBaseTableViewCellActionType)type value:(id)value {
    switch (type) {
        case TCHomeBaseTableViewCellActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

@end
