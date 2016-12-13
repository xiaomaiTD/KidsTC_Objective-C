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
static NSString *const ProductCellID = @"ProductOrderFreeDetailProductCell";
static NSString *const StoreCellID = @"ProductOrderFreeDetailStoreCell";
static NSString *const AddressCellID = @"ProductOrderFreeDetailAddressCell";
static NSString *const TimeCellID = @"ProductOrderFreeDetailTimeCell";
static NSString *const LotteryTipCellID = @"ProductOrderFreeDetailLotteryTipCell";
static NSString *const LotteryCellID = @"ProductOrderFreeDetailLotteryCell";
static NSString *const LotteryItemCellID = @"ProductOrderFreeDetailLotteryItemCell";
static NSString *const MoreLotteryCellID = @"ProductOrderFreeDetailMoreLotteryCell";

@interface ProductOrderFreeDetailView ()<UITableViewDelegate,UITableViewDataSource,ProductOrderFreeDetailToolBarDelegate,ProductOrderFreeDetailInfoBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderFreeDetailInfoBaseCell *> *> *sections;
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
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kProductOrderFreeDetailToolBarH, 0);
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailInfoBaseCell" bundle:nil] forCellReuseIdentifier:CellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailProductCell" bundle:nil] forCellReuseIdentifier:ProductCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailStoreCell" bundle:nil] forCellReuseIdentifier:StoreCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailLotteryTipCell" bundle:nil] forCellReuseIdentifier:LotteryTipCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailLotteryCell" bundle:nil] forCellReuseIdentifier:LotteryCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailLotteryItemCell" bundle:nil] forCellReuseIdentifier:LotteryItemCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeDetailMoreLotteryCell" bundle:nil] forCellReuseIdentifier:MoreLotteryCellID];
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)reloadInfoData {
    self.toolBar.data = self.infoData;
    [self setupSections:0];
    [self.tableView reloadData];
}

- (void)reloadLotteryData:(NSInteger)count {
    [self setupSections:count];
    [self.tableView reloadData];
}

- (void)setupSections:(NSInteger)count {
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    if (self.infoData) {
        [section00 addObject:[self cellWithID:ProductCellID]];
    }
    if (section00.count>0) [sections addObject:section00];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.infoData.storeInfo) {
        [section01 addObject:[self cellWithID:StoreCellID]];
        [section01 addObject:[self cellWithID:AddressCellID]];
    }
    if (self.infoData.time) {
        [section01 addObject:[self cellWithID:TimeCellID]];
    }
    if (!self.infoData.isLottery) {
        [section01 addObject:[self cellWithID:LotteryTipCellID]];
        [section01 addObject:[self cellWithID:LotteryCellID]];
        if (self.infoData.freeType == FreeTypeLottery) {
            [section01 addObjectsFromArray:[self resultListsCells:count]];
        }
        if (section01.count>0) [sections addObject:section01];
    }else{
        if (section01.count>0) [sections addObject:section01];
        NSMutableArray *section02 = [NSMutableArray array];
        [section02 addObject:[self cellWithID:LotteryCellID]];
        if (self.infoData.freeType == FreeTypeLottery) {
            [section02 addObjectsFromArray:[self resultListsCells:count]];
        }
        if (section02.count>0) [sections addObject:section02];
    }
    self.sections = [NSArray arrayWithArray:sections];
}

- (NSArray *)resultListsCells:(NSInteger)count {
    NSMutableArray *section = [NSMutableArray array];
    NSArray<ProductOrderFreeDetailLotteryItem *> *resultLists = self.lotteryData.ResultLists;
    [resultLists enumerateObjectsUsingBlock:^(ProductOrderFreeDetailLotteryItem *obj, NSUInteger idx, BOOL *stop) {
        ProductOrderFreeDetailLotteryItemCell *lotteryItemCell = [self.tableView dequeueReusableCellWithIdentifier:LotteryItemCellID];
        lotteryItemCell.item = obj;
        if (lotteryItemCell) [section addObject:lotteryItemCell];
    }];
    if (count>=TCPAGECOUNT) [section addObject:[self cellWithID:MoreLotteryCellID]];
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
            cell.delegate = self;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:CellID];
}

#pragma mark - ProductOrderFreeDetailInfoBaseCellDelegate

- (void)productOrderFreeDetailInfoBaseCell:(ProductOrderFreeDetailInfoBaseCell *)cell actionType:(ProductOrderFreeDetailInfoBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailView:actionType:value:)]) {
        [self.delegate productOrderFreeDetailView:self actionType:(ProductOrderFreeDetailViewActionType)type value:value];
    }
}

- (void)setupToolBar {
    ProductOrderFreeDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderFreeDetailToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - kProductOrderFreeDetailToolBarH, SCREEN_WIDTH, kProductOrderFreeDetailToolBarH);
    toolBar.delegate = self;
    toolBar.hidden = YES;
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

- (nullable __kindof UITableViewCell *)cellWithID:(NSString *)ID {
    return [self.tableView dequeueReusableCellWithIdentifier:ID];
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

@end
