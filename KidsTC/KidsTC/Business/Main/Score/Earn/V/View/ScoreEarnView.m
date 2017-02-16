//
//  ScoreEarnView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "NSString+Category.h"

#import "ScoreEarnShowItem.h"

#import "ScoreEarnBaseCell.h"
#import "ScoreEarnHeaderCell.h"
#import "ScoreEarnExchangeCell.h"
#import "ScoreEarnCommentCell.h"
#import "ScoreEarnMemberTipCell.h"
#import "ScoreEarnMemberLargeCell.h"

static NSString *const BaseCellID = @"ScoreEarnBaseCell";
static NSString *const HeaderCellID = @"ScoreEarnHeaderCell";
static NSString *const ExchangeCellID = @"ScoreEarnExchangeCell";
static NSString *const CommentCellID = @"ScoreEarnCommentCell";
static NSString *const MemberTipCellID = @"ScoreEarnMemberTipCell";
static NSString *const MemberLargeCellID = @"ScoreEarnMemberLargeCell";

@interface ScoreEarnView ()<UITableViewDelegate,UITableViewDataSource,ScoreEarnBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray<NSArray<ScoreEarnShowItem *> *> *items;
@end

@implementation ScoreEarnView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 66;
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        self.isLoadProducts = NO;
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
    if ([self.delegate respondsToSelector:@selector(scoreEarnView:actionType:value:)]) {
        [self.delegate scoreEarnView:self actionType:ScoreEarnViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)registerCells {
    [self registerCell:@"ScoreEarnBaseCell" cellId:BaseCellID];
    [self registerCell:@"ScoreEarnHeaderCell" cellId:HeaderCellID];
    [self registerCell:@"ScoreEarnExchangeCell" cellId:ExchangeCellID];
    [self registerCell:@"ScoreEarnCommentCell" cellId:CommentCellID];
    [self registerCell:@"ScoreEarnMemberTipCell" cellId:MemberTipCellID];
    [self registerCell:@"ScoreEarnMemberLargeCell" cellId:MemberLargeCellID];
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

- (void)dealWithUI:(NSUInteger)loadCount isComment:(BOOL)isComment {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (isComment) {
        if (loadCount<1) {
            self.isLoadProducts = YES;
            [self getDataRefresh:NO];
        }
    }else{
        if (loadCount<1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    [self reloadData];
    
    if (self.items.count<1) {
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
    
    
    NSMutableArray *section01 = [NSMutableArray array];
    
    ScoreEarnShowItem *headerItem = [ScoreEarnShowItem itemWithCellId:HeaderCellID index:0];
    if (headerItem) [section01 addObject:headerItem];
    ScoreEarnShowItem *exchangeItem = [ScoreEarnShowItem itemWithCellId:ExchangeCellID index:0];
    if (exchangeItem) [section01 addObject:exchangeItem];
    if (section01.count>0) [sections addObject:section01];
    
    [self.orderItems enumerateObjectsUsingBlock:^(ScoreOrderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *section02 = [NSMutableArray array];
        if (idx==0) {
            ScoreEarnShowItem *commentTitleItem = [ScoreEarnShowItem itemWithCellId:MemberTipCellID index:0];
            commentTitleItem.title = @"评论赚积分";
            if (commentTitleItem) [section02 addObject:commentTitleItem];
        }
        ScoreEarnShowItem *commentItem = [ScoreEarnShowItem itemWithCellId:CommentCellID index:idx];
        if (commentItem) [section02 addObject:commentItem];
        if (section02.count>0) [sections addObject:section02];
    }];
    
    if (self.productData.products.count>0) {
        NSMutableArray *section03 = [NSMutableArray array];
        ScoreEarnShowItem *memberTipItem = [ScoreEarnShowItem itemWithCellId:MemberTipCellID index:0];
        memberTipItem.title = self.productData.title;
        if (memberTipItem) [section03 addObject:memberTipItem];
        [self.productData.products enumerateObjectsUsingBlock:^(ScoreProductItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ScoreEarnShowItem *memberLargeItem = [ScoreEarnShowItem itemWithCellId:MemberLargeCellID index:idx];
            if (memberLargeItem) [section03 addObject:memberLargeItem];
        }];
        if (section03.count>0) [sections addObject:section03];
    }
    
    self.items = [NSArray arrayWithArray:sections];
}

#pragma mark UITableViewDelegate,UITableViewDataSourc

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.items.count) {
        return self.items[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section==self.items.count-1)?CGFLOAT_MIN:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section<self.items.count) {
        NSArray<ScoreEarnShowItem *> *rows = self.items[section];
        if (row<rows.count) {
            ScoreEarnShowItem *item = rows[row];
            NSString *cellId = item.cellId;
            ScoreEarnBaseCell *cell = [self cellWithID:cellId];
            cell.userInfoData = self.userInfoData;
            cell.orderItems = self.orderItems;
            cell.productData = self.productData;
            cell.delegate = self;
            cell.item = item;
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

#pragma mark ScoreEarnBaseCellDelegate

- (void)scoreEarnBaseCell:(ScoreEarnBaseCell *)cell actionType:(ScoreEarnBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(scoreEarnView:actionType:value:)]) {
        [self.delegate scoreEarnView:self actionType:(ScoreEarnViewActionType)type value:value];
    }
}

@end
