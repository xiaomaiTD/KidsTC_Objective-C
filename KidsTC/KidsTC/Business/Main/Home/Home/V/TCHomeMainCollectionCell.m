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
#import "TCHomeFloor.h"


static CGRect tableViewFrame;

static NSUInteger const pageCount = 10;

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

+ (void)load {
    [super load];
    if (CGRectEqualToRect(tableViewFrame, CGRectZero)) {
        tableViewFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = tableViewFrame;
}

- (void)setCategory:(TCHomeCategory *)category {
    _category = category;
    if (category.floors.count<1) {
        [self.tableView.mj_header beginRefreshing];
    }
    [self scrollViewDidScroll:self.tableView];
    [self.tableView reloadData];
    self.tableView.backgroundView = nil;
}

- (void)backToTop {
    [self.tableView scrollToTop];
}

- (void)scrollTo:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)scrollY:(CGFloat)offsetY {
    CGPoint offset = self.tableView.contentOffset;
    offset.y = offsetY;
    [self.tableView setContentOffset:offset animated:NO];
    [self scrollViewDidScroll:self.tableView];
}

- (void)endDragY:(CGFloat)offsetY {
    CGPoint offset = self.tableView.contentOffset;
    offset.y = offsetY;
    [self.tableView setContentOffset:offset animated:NO];
    [self scrollViewDidEndDragging:self.tableView willDecelerate:YES];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    [tableView registerClass:[TCHomeBaseTableViewCell class] forCellReuseIdentifier:kTCHomeBaseTableViewCellID];
    self.tableView = tableView;
    
    [self setupMJ];
}

- (void)setupMJ{
    
    WeakSelf(self)
    RefreshHeader *mj_header = [HomeRefreshHeader headerWithRefreshingBlock:^{
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
    //mj_footer.triggerAutomaticallyRefreshPercent = -4.0;
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
    self.category.page = 1;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    NSMutableArray<TCHomeCategory *> *categorys = [NSMutableArray array];
    NSMutableArray<TCHomeModule *> *modules = [NSMutableArray array];
    NSMutableArray<TCHomeFloor *> *mainFloors = [NSMutableArray array];
    dispatch_group_async(group, queue, ^{
        NSDictionary *param = @{@"type":type,
                                @"category":category};
        [Request startSyncName:@"GET_PAGE_HOME_NEW_V2" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeModel *model = [TCHomeModel modelWithDictionary:dic];
            [mainFloors addObjectsFromArray:model.data.floors];
            [categorys addObjectsFromArray:model.data.categorys];
            [model.data.modules enumerateObjectsUsingBlock:^(TCHomeModule *obj, NSUInteger idx, BOOL *stop) {
                NSString *name = [NSString stringWithFormat:@"%@",obj.name];
                if (name.length>0) {
                    [modules addObject:obj];
                }
            }];
        } failure:nil];
    });
    
    NSMutableArray<TCHomeFloor *> *recommendFloors = [NSMutableArray array];
    __block NSUInteger recommendCount = 0;
    dispatch_group_async(group, queue, ^{
        NSDictionary *param = @{@"populationType":type,
                                @"page":@(self.category.page),
                                @"pageCount":@(pageCount),
                                @"homeCategory":category};
        [Request startSyncName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeRecommendModel *model = [TCHomeRecommendModel modelWithDictionary:dic];
            [recommendFloors addObjectsFromArray:model.floors];
            recommendCount = recommendFloors.count;
        } failure:nil];
    });
    
    dispatch_group_notify(group, queue, ^{
        NSMutableArray<TCHomeFloor *> *allFloors = [NSMutableArray array];
        [allFloors addObjectsFromArray:mainFloors];
        if (recommendCount>0) {
            TCHomeFloor *floor = recommendFloors[0];
            TCHomeFloorTitleContent *titleContent = [TCHomeFloorTitleContent new];
            titleContent.name = @"童成精选";
            titleContent.subName = @"每日10:00更新";
            floor.titleType = TCHomeFloorTitleContentTypeRecommend;
            floor.hasTitle = YES;
            floor.titleContent = titleContent;
            floor.marginTop = mainFloors.count<1?0:12;
            [floor modelCustomTransformFromDictionary:nil];
        }
        [allFloors addObjectsFromArray:recommendFloors];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (updateCategorys) {
                if (![self.delegate respondsToSelector:@selector(tcHomeMainCollectionCell:actionType:value:)]) {
                    [self dealWitMJ:0 totalCount:allFloors.count];
                    return;
                }
                TCHomeCategory *category;
                BOOL showCategory;
                if (categorys.count<1) {
                    category = [TCHomeCategory new];
                    [categorys addObject:category];
                    showCategory = false;
                    tableViewFrame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
                }else{
                    category = categorys[0];
                    showCategory = true;
                    tableViewFrame = CGRectMake(0, 64 + 40, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40 - 49);
                }
                self.tableView.frame = tableViewFrame;
                
                category.floors = [NSArray arrayWithArray:allFloors];
                category.modules = [NSArray arrayWithArray:modules];
                NSDictionary *dic = @{@"categorys":categorys,
                                      @"showCategory":@(showCategory)};
                [self.delegate tcHomeMainCollectionCell:self actionType:TCHomeMainCollectionCellActionTypeLoadData value:dic];
            }else{
                self.category.floors = [NSArray arrayWithArray:allFloors];
                self.category.modules = [NSArray arrayWithArray:modules];
                [self.tableView reloadData];
            }
            [self dealWitMJ:recommendCount totalCount:allFloors.count];
        });
    });
}

- (void)loadDataMore {
    
    NSString *type = [User shareUser].role.roleIdentifierString;
    NSString *category = self.category.sysNo;
    category = [category isNotNull]?category:@"";
    
    NSMutableArray<TCHomeFloor *> *allFloors = [NSMutableArray arrayWithArray:self.category.floors];
    __block NSUInteger recommendCount = 0;
    NSDictionary *param = @{@"populationType":type,
                            @"page":@(++self.category.page),
                            @"pageCount":@(pageCount),
                            @"homeCategory":category};
    [Request startWithName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCHomeRecommendModel *model = [TCHomeRecommendModel modelWithDictionary:dic];
        [allFloors addObjectsFromArray:model.floors];
        recommendCount = model.floors.count;
        self.category.floors = [NSArray arrayWithArray:allFloors];
        [self.tableView reloadData];
        [self dealWitMJ:recommendCount totalCount:allFloors.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self dealWitMJ:recommendCount totalCount:allFloors.count];
    }];
}


- (void)dealWitMJ:(NSUInteger)recommendCount
       totalCount:(NSUInteger)totalCount
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (recommendCount < pageCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self dealWithBG];
}

- (void)dealWithBG {
    if (self.category.floors.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height)
                                                                          image:nil
                                                                    description:@"啥都木有啊···"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(tcHomeMainCollectionCell:actionType:value:)]) {
        CGFloat y = scrollView.contentOffset.y;
        NSUInteger index = [self.tableView indexPathsForVisibleRows].firstObject.section;
        NSDictionary *dic = @{@"y":@(y),
                              @"index":@(index)};
        [self.delegate tcHomeMainCollectionCell:self actionType:TCHomeMainCollectionCellActionTypeScroll value:dic];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat y = scrollView.contentOffset.y;
    if (y < -64) {
        if ([self.delegate respondsToSelector:@selector(tcHomeMainCollectionCell:actionType:value:)]) {
            [self.delegate tcHomeMainCollectionCell:self actionType:TCHomeMainCollectionCellActionTypeHomeRefresh value:nil];
        }
    }
}

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
            if ([self.delegate respondsToSelector:@selector(tcHomeMainCollectionCell:actionType:value:)]) {
                [self.delegate tcHomeMainCollectionCell:self actionType:TCHomeMainCollectionCellActionTypeSegue value:value];
            }
        }
            break;
    }
}

@end
