//
//  ProductOrderFreeDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailView.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "ProductOrderFreeDetailToolBar.h"

#import "ProductOrderFreeDetailInfoBaseCell.h"
#import "ProductOrderFreeDetailProductCell.h"
#import "ProductOrderFreeDetailStoreCell.h"
#import "ProductOrderFreeDetailAddressCell.h"
#import "ProductOrderFreeDetailTimeCell.h"
#import "ProductOrderFreeDetailLotteryTipCell.h"
#import "ProductOrderFreeDetailLotteryCell.h"
#import "ProductOrderFreeDetailLotteryItemCell.h"
#import "ProductOrderFreeDetailMoreLotteryCell.h"

static NSString *const CellID = @"ProductOrderFreeDetailInfoBaseCell";

@interface ProductOrderFreeDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductOrderFreeDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderFreeDetailInfoBaseCell *> *> *sections;
@property (nonatomic, strong) ProductOrderFreeDetailProductCell *productCell;
@property (nonatomic, strong) ProductOrderFreeDetailStoreCell *storeCell;
@property (nonatomic, strong) ProductOrderFreeDetailAddressCell *addressCell;
@property (nonatomic, strong) ProductOrderFreeDetailTimeCell *timeCell;
@property (nonatomic, strong) ProductOrderFreeDetailLotteryTipCell *lotteryTipCell;
@property (nonatomic, strong) ProductOrderFreeDetailLotteryCell *lotteryCell;
@property (nonatomic, strong) ProductOrderFreeDetailMoreLotteryCell *moreLotteryCell;

@property (nonatomic, strong) ProductOrderFreeDetailToolBar *toolBar;

@end

@implementation ProductOrderFreeDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailInfoBaseCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)reloadInfoData {
    self.toolBar.data = self.infoData;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadLotteryData {
    [self setupSections];
    [self.tableView reloadData];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    if (self.infoData) {
        [section00 addObject:self.productCell];
    }
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.infoData.storeInfo) {
        [section01 addObject:self.storeCell];
        [section01 addObject:self.addressCell];
    }
    if (self.infoData.time) {
        [section01 addObject:self.timeCell];
    }
    if (!self.infoData.isLottery) {
        [section01 addObject:self.lotteryTipCell];
        [section01 addObject:self.lotteryCell];
        [section01 addObjectsFromArray:self.resultListsCells];
        if (section01.count>0) [sections addObject:section01];
    }else{
        if (section01.count>0) [sections addObject:section01];
        NSMutableArray *section02 = [NSMutableArray array];
        [section02 addObject:self.lotteryCell];
        [section02 addObjectsFromArray:self.resultListsCells];
        if (section02.count>0) [sections addObject:section02];
    }
    self.sections = [NSArray arrayWithArray:sections];
}

- (NSArray *)resultListsCells {
    NSMutableArray *section = [NSMutableArray array];
    NSArray<ProductOrderFreeDetailLotteryItem *> *resultLists = self.lotteryData.ResultLists;
    [resultLists enumerateObjectsUsingBlock:^(ProductOrderFreeDetailLotteryItem *obj, NSUInteger idx, BOOL *stop) {
        ProductOrderFreeDetailLotteryItemCell *lotteryItemCell = self.lotteryItemCell;
        lotteryItemCell.item = obj;
        if (lotteryItemCell) [section addObject:lotteryItemCell];
    }];
    if (resultLists.count>0) [section addObject:self.moreLotteryCell];
    return section;
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
    return (section==self.sections.count-1)?0.001:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<ProductOrderFreeDetailInfoBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductOrderFreeDetailInfoBaseCell *cell = rows[row];
            cell.lotteryData = self.lotteryData;
            cell.infoData = self.infoData;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:CellID];
}

- (void)setupToolBar {
    ProductOrderFreeDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderFreeDetailToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - kProductOrderFreeDetailToolBarH, SCREEN_WIDTH, kProductOrderFreeDetailToolBarH);
    toolBar.delegate = self;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma marl - ProductOrderFreeDetailToolBarDelegate

- (void)productOrderFreeDetailToolBar:(ProductOrderFreeDetailToolBar *)toolBar actionType:(ProductOrderFreeDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailView:actionType:value:)]) {
        [self.delegate productOrderFreeDetailView:self actionType:(ProductOrderFreeDetailViewActionType)type value:value];
    }
}

#pragma mark - helpers

- (ProductOrderFreeDetailProductCell *)productCell {
    if (!_productCell) {
        _productCell = [self viewWithNib:@"ProductOrderFreeDetailProductCell"];
    }
    return _productCell;
}

- (ProductOrderFreeDetailStoreCell *)storeCell {
    if (!_storeCell) {
        _storeCell = [self viewWithNib:@"ProductOrderFreeDetailStoreCell"];
    }
    return _storeCell;
}

- (ProductOrderFreeDetailAddressCell *)addressCell {
    if (!_addressCell) {
        _addressCell = [self viewWithNib:@"ProductOrderFreeDetailAddressCell"];
    }
    return _addressCell;
}

- (ProductOrderFreeDetailTimeCell *)timeCell {
    if (!_timeCell) {
        _timeCell = [self viewWithNib:@"ProductOrderFreeDetailTimeCell"];
    }
    return _timeCell;
}

- (ProductOrderFreeDetailLotteryTipCell *)lotteryTipCell {
    if (!_lotteryTipCell) {
        _lotteryTipCell = [self viewWithNib:@"ProductOrderFreeDetailLotteryTipCell"];
    }
    return _lotteryTipCell;
}

- (ProductOrderFreeDetailLotteryCell *)lotteryCell {
    if (!_lotteryCell) {
        _lotteryCell = [self viewWithNib:@"ProductOrderFreeDetailLotteryCell"];
    }
    return _lotteryCell;
}

- (ProductOrderFreeDetailLotteryItemCell *)lotteryItemCell {
    return [self viewWithNib:@"ProductOrderFreeDetailLotteryItemCell"];
}

- (ProductOrderFreeDetailMoreLotteryCell *)moreLotteryCell {
    if (!_moreLotteryCell) {
        _moreLotteryCell = [self viewWithNib:@"ProductOrderFreeDetailMoreLotteryCell"];
    }
    return _moreLotteryCell;
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

@end
