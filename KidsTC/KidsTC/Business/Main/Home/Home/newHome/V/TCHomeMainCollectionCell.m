//
//  TCHomeMainCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/17.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeMainCollectionCell.h"
#import "TCHomeBaseTableViewCell.h"
#import "HomeRefreshHeader.h"
#import "RefreshFooter.h"
#import "GHeader.h"
#import "TCHomeModel.h"
#import "TCHomeRecommendModel.h"
#import "NSString+Category.h"

static NSString *const kTCHomeBaseTableViewCellID = @"TCHomeBaseTableViewCell";

@interface TCHomeMainCollectionCell ()<UITableViewDelegate,UITableViewDataSource,TCHomeBaseTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TCHomeMainCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)setCategory:(TCHomeCategory *)category {
    _category = category;
    if (category.floors.count<1) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        [self.tableView reloadData];
    }
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    [tableView registerClass:[TCHomeBaseTableViewCell class] forCellReuseIdentifier:kTCHomeBaseTableViewCellID];
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
    
    mj_footer.automaticallyRefresh = YES;
    mj_footer.triggerAutomaticallyRefreshPercent = -4.0;
}

- (void)loadData:(BOOL)refresh {
    if (refresh) {
        BOOL updateCategorys = (!_category) ||
                               (!_category.sysNo) ||
                               (_category.sysNo.length == 0) ||
                               ([_category.sysNo isEqualToString:@"0"]);
        [self loadDataNew:updateCategorys];
    }else{
        [self loadDataMore];
    }
}

#pragma mark - loadData

- (void)loadDataNew:(BOOL)updateCategorys {
    NSString *type = [User shareUser].role.roleIdentifierString;
    NSString *category = self.category.sysNo;
    category = [category isNotNull]?category:@"";
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    
    __block NSArray<TCHomeCategory *> *categorys;
    
    __block NSMutableArray<TCHomeFloor *> *mainFloors = [NSMutableArray array];
    dispatch_group_async(group, queue, ^{
        NSDictionary *param = @{@"type":@"13",
                                @"category":category};
        [Request startSyncName:@"GET_PAGE_HOME_NEW_V2" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeModel *model = [TCHomeModel modelWithDictionary:dic];
            [mainFloors addObjectsFromArray:model.data.floors];
            categorys = model.data.categorys;
        } failure:nil];
    });
    
    __block NSMutableArray<TCHomeFloor *> *recommendFloors = [NSMutableArray array];
    dispatch_group_async(group, queue, ^{
        
        NSDictionary *param = @{@"populationType":@"13",
                                @"page":@(1),
                                @"pageCount":@(10)};
        [Request startSyncName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeRecommendModel *model = [TCHomeRecommendModel modelWithDictionary:dic];
            [recommendFloors addObjectsFromArray:model.floors];
        } failure:nil];
    });
    dispatch_group_notify(group, queue, ^{
        NSMutableArray<TCHomeFloor *> *allFloors = [NSMutableArray array];
        [allFloors addObjectsFromArray:mainFloors];
        [allFloors addObjectsFromArray:recommendFloors];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (updateCategorys) {
                TCHomeCategory *category = categorys[0];
                category.floors = [NSArray arrayWithArray:allFloors];
                if ([self.delegate respondsToSelector:@selector(tcHomeMainCollectionCell:actionType:value:)]) {
                    [self.delegate tcHomeMainCollectionCell:self actionType:TCHomeMainCollectionCellActionTypeLoadData value:categorys];
                }
            }else{
                self.category.floors = [NSArray arrayWithArray:allFloors];
                [self.tableView reloadData];
            }
            [self dealWitMJ];
        });
    });
}

- (void)loadDataMore {
    
    __block NSMutableArray<TCHomeFloor *> *allFloors = [NSMutableArray arrayWithArray:self.category.floors];
    NSDictionary *param = @{@"populationType":@"13",
                            @"page":@(2),
                            @"pageCount":@(10)};
    [Request startWithName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCHomeRecommendModel *model = [TCHomeRecommendModel modelWithDictionary:dic];
        [allFloors addObjectsFromArray:model.floors];
        self.category.floors = [NSArray arrayWithArray:allFloors];
        [self.tableView reloadData];
        [self dealWitMJ];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self dealWitMJ];
    }];
}


- (void)dealWitMJ {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.category.floors.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<self.category.floors.count) {
        return self.category.floors[indexPath.section].floorHeight;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section<self.category.floors.count) {
        return self.category.floors[section].marginTop;
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
    if (indexPath.section<self.category.floors.count) {
        cell.floor = self.category.floors[indexPath.section];
    }
    return cell;
}

#pragma mark - TCHomeBaseTableViewCellDelegate

- (void)tcHomeBaseTableViewCell:(TCHomeBaseTableViewCell *)cell actionType:(TCHomeBaseTableViewCellActionType)type value:(id)value {
    switch (type) {
        case TCHomeBaseTableViewCellActionTypeSegue:
        {
//            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

@end
