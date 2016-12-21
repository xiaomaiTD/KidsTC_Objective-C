//
//  SettlementResultNewView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"


#import "RecommendProductSettlementResultView.h"

#import "SettlementResultNewNormalCell.h"
#import "SettlementResultNewFreeCell.h"

static NSString *const NormalCellID = @"SettlementResultNewNormalCell";
static NSString *const FreeCellID = @"SettlementResultNewFreeCell";

@interface SettlementResultNewView ()<UITableViewDelegate,UITableViewDataSource,SettlementResultNewBaseCellDelegate,RecommendProductViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RecommendProductSettlementResultView *footerView;
@end

@implementation SettlementResultNewView

- (RecommendProductSettlementResultView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendProductSettlementResultView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:@"SettlementResultNewNormalCell" bundle:nil] forCellReuseIdentifier:NormalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettlementResultNewFreeCell" bundle:nil] forCellReuseIdentifier:FreeCellID];
    [self resetFooterView];
    [self setupMJ];
}

- (void)setupMJ {
    WeakSelf(self);
    RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        [self.footerView nilData];
        [self resetFooterView];
        [self loadData:YES];
    }];
    self.tableView.mj_header = header;
    RefreshFooter *footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self);
        [self loadData:NO];
    }];
    self.tableView.mj_footer = footer;
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewView:actionType:value:)]) {
        [self.delegate settlementResultNewView:self actionType:SettlementResultNewViewActionTypeLoadRecommend value:@(refresh)];
    }
}

- (void)reloadData:(NSInteger)count {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self resetFooterView];
    
    if (count<TCPAGECOUNT) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)resetFooterView {
    [self.footerView reloadData];
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.footerView contentHeight]);
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_productType) {
        case ProductDetailTypeFree:
        {
            SettlementResultNewFreeCell *cell = [tableView dequeueReusableCellWithIdentifier:FreeCellID];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
            break;
        default:
        {
            SettlementResultNewNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.delegate = self;
            cell.paid = self.paid;
            
            return cell;
        }
            break;
    }
}

#pragma mark - SettlementResultNewBaseCellDelegate

- (void)settlementResultNewBaseCell:(SettlementResultNewBaseCell *)cell actionType:(SettlementResultNewBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewView:actionType:value:)]) {
        [self.delegate settlementResultNewView:self actionType:(SettlementResultNewViewActionType)type value:value];
    }
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(settlementResultNewView:actionType:value:)]) {
                [self.delegate settlementResultNewView:self actionType:SettlementResultNewViewActionTypeSegue value:value];
            }
        }
            break;
        default:
            break;
    }
}


@end
