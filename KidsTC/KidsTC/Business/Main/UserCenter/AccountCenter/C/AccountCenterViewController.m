//
//  AccountCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterViewController.h"
#import "GHeader.h"

#import "AccountCenterModel.h"

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

static NSString *const ID = @"UITableViewCell";

@interface AccountCenterViewController ()<UITableViewDelegate,UITableViewDataSource,AccountCenterBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<AccountCenterBaseCell *> *> *sections;
@property (nonatomic, strong) AccountCenterModel *model;
@end

@implementation AccountCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10901;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    
    AccountCenterHeader *header = [self viewWithNib:@"AccountCenterHeader"];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    tableView.tableHeaderView = header;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadData];
}

- (void)loadData{
    [Request startWithName:@"GET_USER_CENTER" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccess:[AccountCenterModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(AccountCenterModel *)model {
    self.model = model;
    [self setupMainSections];
    [self.tableView reloadData];
}

- (void)loadDataFailure:(NSError *)error {
    
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

- (void)setupMainSections {
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    [section00 addObject:self.collectonsCell];
    if (section00.count>0) {
        [sections addObject:section00];
    }
    
    NSMutableArray *section01 = [NSMutableArray array];
    [section01 addObject:self.ordersCell];
    if (section01.count>0) {
        [sections addObject:section01];
    }
    
    NSMutableArray *section02 = [NSMutableArray array];
    [section02 addObject:self.numsCell];
    if (section02.count>0) {
        [sections addObject:section02];
    }
    
    NSMutableArray *section03 = [NSMutableArray array];
    [section03 addObject:self.activitiesCell];
    if (section03.count>0) {
        [sections addObject:section03];
    }
    
    NSMutableArray *section04 = [NSMutableArray array];
    [section04 addObject:self.itemsCell];
    if (section04.count>0) {
        [sections addObject:section04];
    }
    
    NSMutableArray *section05 = [NSMutableArray array];
    if (self.model.data.config.banners.count>0) {
        [section05 addObject:self.bannersCell];
    }
    if (section05.count>0) {
        [sections addObject:section05];
    }
    
    NSMutableArray *section06 = [NSMutableArray array];
    if (sections.count>0) {
        [section06 addObject:self.tipsCell];
    }
    if (section06.count>0) {
        [sections addObject:section06];
    }
    
    NSMutableArray *section07 = [NSMutableArray array];
    [section07 addObject:self.recommendsCell];
    [section07 addObject:self.recommendsCell];
    if (section07.count>0) {
        [sections addObject:section07];
    }
    
    self.sections = [NSMutableArray arrayWithArray:sections];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<AccountCenterBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            AccountCenterBaseCell *cell = rows[row];
            cell.delegate =  self;
            cell.model = self.model;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

#pragma mark - AccountCenterBaseCellDelegate

- (void)accountCenterBaseCell:(AccountCenterBaseCell *)cell actionType:(AccountCenterCellActionType)type value:(id)value {
    
    [self checkLogin:type relultBlock:^{
        [self checkOverAccountCenterBaseCell:cell actionType:type value:value];
    }];
}

- (void)checkLogin:(AccountCenterCellActionType)type relultBlock:(void(^)())resultBlock{
    
    switch (type) {
            
        case AccountCenterCellActionTypeCollectionProduct:
        case AccountCenterCellActionTypeCollectionStore:
        case AccountCenterCellActionTypeCollectionContent:
        case AccountCenterCellActionTypeCollectionPeople:
            
        case AccountCenterCellActionTypeAllOrder:
        case AccountCenterCellActionTypeWaitPay:
        case AccountCenterCellActionTypeWaitUse:
        case AccountCenterCellActionTypeWaitReceipt:
        case AccountCenterCellActionTypeWaitComment:
        case AccountCenterCellActionTypeRefund:
            
        case AccountCenterCellActionTypeScore:
        case AccountCenterCellActionTypeRadish:
        case AccountCenterCellActionTypeCoupon:
        case AccountCenterCellActionTypeECard:
        case AccountCenterCellActionTypeBalance:
            
        case AccountCenterCellActionTypeHistory:
        case AccountCenterCellActionTypeMyFlash:
        case AccountCenterCellActionTypeMyAppoinment:
            
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                if(resultBlock)resultBlock();
            }];
        }
            break;
            
        case AccountCenterCellActionTypeRadishMall:
        case AccountCenterCellActionTypeShareMakeMoney:
        case AccountCenterCellActionTypeBringUpHeadline:
        case AccountCenterCellActionTypeCustomerServices:
        case AccountCenterCellActionTypeOpinion:
        {
            if(resultBlock)resultBlock();
        }
    }
}

- (void)checkOverAccountCenterBaseCell:(AccountCenterBaseCell *)cell actionType:(AccountCenterCellActionType)type value:(id)value {
    
    switch (type) {
        case AccountCenterCellActionTypeCollectionProduct:
        {
            
        }
            break;
        case AccountCenterCellActionTypeCollectionStore:
        {
            
        }
            break;
        case AccountCenterCellActionTypeCollectionContent:
        {
            
        }
            break;
        case AccountCenterCellActionTypeCollectionPeople:
        {
            
        }
            break;
        case AccountCenterCellActionTypeAllOrder:
        {
            
        }
            break;
        case AccountCenterCellActionTypeWaitPay:
        {
            
        }
            break;
        case AccountCenterCellActionTypeWaitUse:
        {
            
        }
            break;
        case AccountCenterCellActionTypeWaitReceipt:
        {
            
        }
            break;
        case AccountCenterCellActionTypeWaitComment:
        {
            
        }
            break;
        case AccountCenterCellActionTypeRefund:
        {
            
        }
            break;
        case AccountCenterCellActionTypeScore:
        {
            
        }
            break;
        case AccountCenterCellActionTypeRadish:
        {
            
        }
            break;
        case AccountCenterCellActionTypeCoupon:
        {
            
        }
            break;
        case AccountCenterCellActionTypeECard:
        {
            
        }
            break;
        case AccountCenterCellActionTypeBalance:
        {
            
        }
            break;
        case AccountCenterCellActionTypeHistory:
        {
            
        }
            break;
        case AccountCenterCellActionTypeRadishMall:
        {
            
        }
            break;
        case AccountCenterCellActionTypeMyFlash:
        {
            
        }
            break;
        case AccountCenterCellActionTypeMyAppoinment:
        {
            
        }
            break;
        case AccountCenterCellActionTypeShareMakeMoney:
        {
            
        }
            break;
        case AccountCenterCellActionTypeBringUpHeadline:
        {
            
        }
            break;
        case AccountCenterCellActionTypeCustomerServices:
        {
            
        }
            break;
        case AccountCenterCellActionTypeOpinion:
        {
            
        }
            break;
    }
    
}

@end
