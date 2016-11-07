//
//  AccountCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterViewController.h"

#import "AccountCenterHeader.h"
#import "AccountCenterBaseCell.h"
#import "AccountCenterCollectionsCell.h"
#import "AccountCenterOrdersCell.h"
#import "AccountCenterNumsCell.h"
#import "AccountCenterActivitiesCell.h"
#import "AccountCenterItemsCell.h"
#import "AccountCenterBannersCell.h"
#import "AccountCenterTipsCell.h"
#import "AccountCenterRecommendsCell.h"

@interface AccountCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<AccountCenterBaseCell *> *> *sections;
@end

@implementation AccountCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10901;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    AccountCenterHeader *header = [self viewWithNib:@"AccountCenterHeader"];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    tableView.tableHeaderView = header;
    
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (AccountCenterCollectionsCell *)collectonsCell {
    return [self viewWithNib:@"AccountCenterCollectionsCell"];
}

- (AccountCenterOrdersCell *)ordersCell {
    return [self viewWithNib:@"AccountCenterOrdersCell"];
}

- (AccountCenterNumsCell *)numsCell {
    return [self viewWithNib:@"AccountCenterNumsCell"];
}

- (AccountCenterActivitiesCell *)activitiesCell {
    return [self viewWithNib:@"AccountCenterActivitiesCell"];
}

- (AccountCenterItemsCell *)itemsCell {
    return [self viewWithNib:@"AccountCenterItemsCell"];
}

- (AccountCenterBannersCell *)bannersCell {
    return [self viewWithNib:@"AccountCenterBannersCell"];
}

- (AccountCenterTipsCell *)tipsCell {
    return [self viewWithNib:@"AccountCenterTipsCell"];
}

- (AccountCenterRecommendsCell *)recommendsCell {
    return [self viewWithNib:@"AccountCenterRecommendsCell"];
}

- (void)setupSections {
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


@end
