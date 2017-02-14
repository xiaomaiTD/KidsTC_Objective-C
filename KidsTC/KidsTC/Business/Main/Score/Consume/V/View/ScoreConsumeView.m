//
//  ScoreConsumeView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "NSString+Category.h"

#import "ScoreConsumeShowItem.h"

#import "ScoreConsumeBaseCell.h"
#import "ScoreConsumeHeaderCell.h"
#import "ScoreConsumeLargeCell.h"
#import "ScoreConsumeSmallCell.h"
#import "ScoreConsumeTipCell.h"

static NSString *const BaseCellID = @"ScoreConsumeBaseCell";
static NSString *const HeaderCellID = @"ScoreConsumeHeaderCell";
static NSString *const LargeCellID = @"ScoreConsumeLargeCell";
static NSString *const SmallCellID = @"ScoreConsumeSmallCell";
static NSString *const TipCellID = @"ScoreConsumeTipCell";

@interface ScoreConsumeView ()<UITableViewDelegate,UITableViewDataSource,ScoreConsumeBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray<NSArray<ScoreConsumeShowItem *> *> *showItems;
@end

@implementation ScoreConsumeView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 66;
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:NO];
    }];
    self.tableView.mj_footer = mj_footer;
    
    [mj_header beginRefreshing];
    [self registerCells];
}

- (void)getDataRefresh:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(scoreConsumeView:actionType:value:)]) {
        [self.delegate scoreConsumeView:self actionType:ScoreConsumeViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)registerCells {
    [self registerCell:@"ScoreConsumeBaseCell" cellId:BaseCellID];
    [self registerCell:@"ScoreConsumeHeaderCell" cellId:HeaderCellID];
    [self registerCell:@"ScoreConsumeLargeCell" cellId:LargeCellID];
    [self registerCell:@"ScoreConsumeSmallCell" cellId:SmallCellID];
    [self registerCell:@"ScoreConsumeTipCell" cellId:TipCellID];
}

- (void)registerCell:(NSString *)name cellId:(NSString *)cellId {
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:cellId];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    if (![cellID isNotNull]) {
        return [self cellWithID:BaseCellID];
    }
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self reloadData];
    if (self.showItems.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)reloadData {
    [self setupShowItems];
    [self.tableView reloadData];
}

- (void)setupShowItems {
    NSMutableArray *sections = [NSMutableArray array];
    
    [self.topicItems enumerateObjectsUsingBlock:^(ScoreConsumeTopicItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *section01 = [NSMutableArray array];
        ScoreConsumeShowItem *titleItem = [ScoreConsumeShowItem itemWithCellId:TipCellID title:obj.title item:nil];
        if (titleItem) [section01 addObject:titleItem];
        NSString *cellId = nil;
        switch (obj.picType) {
            case ScoreConsumeTopicItemTypeSmall:
            {
                cellId = SmallCellID;
            }
                break;
            case ScoreConsumeTopicItemTypeLarge:
            {
                cellId = LargeCellID;
            }
                break;
            default:
                break;
        }
        if (cellId) {
            [obj.products enumerateObjectsUsingBlock:^(ScoreProductItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ScoreConsumeShowItem *showItem = [ScoreConsumeShowItem itemWithCellId:cellId title:nil item:obj];
                if (showItem) [section01 addObject:showItem];
            }];
        }
        if (section01.count>0) [sections addObject:section01];
    }];
    
    NSArray<ScoreProductItem *> *products = self.productData.products;
    if (products.count>0) {
        NSMutableArray *section02 = [NSMutableArray array];
        ScoreConsumeShowItem *titleItem = [ScoreConsumeShowItem itemWithCellId:TipCellID title:self.productData.title item:nil];
        if (titleItem) [section02 addObject:titleItem];
        [products enumerateObjectsUsingBlock:^(ScoreProductItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ScoreConsumeShowItem *showItem = [ScoreConsumeShowItem itemWithCellId:LargeCellID title:nil item:obj];
            if (showItem) [section02 addObject:showItem];
        }];
        if (section02.count>0) [sections addObject:section02];
    }
    
    if (sections.count>0) {
        NSMutableArray *sectionfirst = sections.firstObject;
        ScoreConsumeShowItem *headerItem = [ScoreConsumeShowItem itemWithCellId:HeaderCellID title:nil item:nil];
        headerItem.userInfoData = self.userInfoData;
        if (headerItem) [sectionfirst insertObject:headerItem atIndex:0];
    }else{
        NSMutableArray *sectionfirst = [NSMutableArray array];
        ScoreConsumeShowItem *headerItem = [ScoreConsumeShowItem itemWithCellId:HeaderCellID title:nil item:nil];
        headerItem.userInfoData = self.userInfoData;
        if (headerItem) [sectionfirst addObject:headerItem];
        if (sectionfirst.count>0) [sections addObject:sectionfirst];
    }
    
    self.showItems = [NSArray arrayWithArray:sections];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.showItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.showItems.count) {
        return self.showItems[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section==self.showItems.count-1)?CGFLOAT_MIN:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section<self.showItems.count) {
        NSArray<ScoreConsumeShowItem *> *rows = self.showItems[section];
        if (row<rows.count) {
            ScoreConsumeShowItem *item = rows[row];
            NSString *cellId = item.cellId;
            ScoreConsumeBaseCell *cell = [self cellWithID:cellId];
            cell.item = item;
            cell.delegate = self;
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark - ScoreConsumeBaseCellDelegate

- (void)scoreConsumeBaseCell:(ScoreConsumeBaseCell *)cell actionType:(ScoreConsumeBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(scoreConsumeView:actionType:value:)]) {
        [self.delegate scoreConsumeView:self actionType:(ScoreConsumeViewActionType)type value:value];
    }
}

@end
