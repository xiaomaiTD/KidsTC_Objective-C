//
//  AccountCenterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterView.h"

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

@interface AccountCenterView ()<UITableViewDelegate,UITableViewDataSource,AccountCenterHeaderDelegate,AccountCenterBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AccountCenterHeader *header;
@property (nonatomic, strong) NSArray<NSArray<AccountCenterBaseCell *> *> *sections;
@end

@implementation AccountCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.estimatedRowHeight = 60;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        tableView.scrollIndicatorInsets = tableView.contentInset;
        [self addSubview:tableView];
        self.tableView = tableView;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        
    }
    return self;
}

- (void)setModel:(AccountCenterModel *)model {
    _model = model;
    self.header.model = model;
    [self setupMainSections];
    [self.tableView reloadData];
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (AccountCenterHeader *)header{
    if (!_header) {
        _header = [self viewWithNib:@"AccountCenterHeader"];
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
        _header.delegate = self;
        self.tableView.tableHeaderView = _header;
    }
    return _header;
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
    return 8;
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

#pragma mark - AccountCenterHeaderDelegate

- (void)accountCenterHeader:(AccountCenterHeader *)header actionType:(AccountCenterHeaderActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(accountCenterView:actionType:value:)]) {
        [self.delegate accountCenterView:self actionType:(AccountCenterViewActionType)type value:value];
    }
}

#pragma mark - AccountCenterBaseCellDelegate

- (void)accountCenterBaseCell:(AccountCenterBaseCell *)cell actionType:(AccountCenterCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(accountCenterView:actionType:value:)]) {
        [self.delegate accountCenterView:self actionType:(AccountCenterViewActionType)type value:value];
    }
}




@end