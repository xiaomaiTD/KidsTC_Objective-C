//
//  FlashBuyProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailView.h"
#import "NSString+Category.h"

#import "FlashBuyProductDetailColumnsHeader.h"

#import "FlashBuyProductDetailBannerCell.h"
#import "FlashBuyProductDetailBaseCell.h"
#import "FlashBuyProductDetailBuyNoticeElementCell.h"
#import "FlashBuyProductDetailBuyNoticeEmptyCell.h"
#import "FlashBuyProductDetailBuyNoticeTitleCell.h"
#import "FlashBuyProductDetailColumnsCell.h"
#import "FlashBuyProductDetailCommentCell.h"
#import "FlashBuyProductDetailCommentMoreCell.h"
#import "FlashBuyProductDetailCommentEmptyCell.h"
#import "FlashBuyProductDetailContentCell.h"
#import "FlashBuyProductDetailInfoCell.h"
#import "FlashBuyProductDetailPriceCell.h"
#import "FlashBuyProductDetailProgressCell.h"
#import "FlashBuyProductDetailRuleCell.h"
#import "FlashBuyProductDetailRuleTitleCell.h"
#import "FlashBuyProductDetailStoreCell.h"
#import "FlashBuyProductDetailStoreEmptyCell.h"
#import "FlashBuyProductDetailWebCell.h"
#import "FlashBuyProductDetailWebEmptyCell.h"
#import "FlashBuyProductDetailSectionEmptyCell.h"

#import "FlashBuyProductDetailToolBar.h"

static NSString *const ColumnsHeaderID = @"FlashBuyProductDetailColumnsHeader";

static NSString *const BannerCellID = @"FlashBuyProductDetailBannerCell";
static NSString *const BaseCellID = @"FlashBuyProductDetailBaseCell";
static NSString *const BuyNoticeElementCellID = @"FlashBuyProductDetailBuyNoticeElementCell";
static NSString *const BuyNoticeEmptyCellID = @"FlashBuyProductDetailBuyNoticeEmptyCell";
static NSString *const BuyNoticeTitleCellID = @"FlashBuyProductDetailBuyNoticeTitleCell";
static NSString *const ColumnsCellID = @"FlashBuyProductDetailColumnsCell";
static NSString *const CommentCellID = @"FlashBuyProductDetailCommentCell";
static NSString *const CommentMoreCellID = @"FlashBuyProductDetailCommentMoreCell";
static NSString *const CommentEmptyCellID = @"FlashBuyProductDetailCommentEmptyCell";
static NSString *const ContentCellID = @"FlashBuyProductDetailContentCell";
static NSString *const InfoCellID = @"FlashBuyProductDetailInfoCell";
static NSString *const PriceCellID = @"FlashBuyProductDetailPriceCell";
static NSString *const ProgressCellID = @"FlashBuyProductDetailProgressCell";
static NSString *const RuleCellID = @"FlashBuyProductDetailRuleCell";
static NSString *const RuleTitleCellID = @"FlashBuyProductDetailRuleTitleCell";
static NSString *const StoreCellID = @"FlashBuyProductDetailStoreCell";
static NSString *const StoreEmptyCellID = @"FlashBuyProductDetailStoreEmptyCell";
static NSString *const WebCellID = @"FlashBuyProductDetailWebCell";
static NSString *const WebEmptyCellID = @"FlashBuyProductDetailWebEmptyCell";
static NSString *const SectionEmptyCellID = @"FlashBuyProductDetailSectionEmptyCell";

@interface FlashBuyProductDetailView ()<UITableViewDelegate,UITableViewDataSource,FlashBuyProductDetailBaseCellDelegate,FlashBuyProductDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<FlashBuyProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) FlashBuyProductDetailToolBar *toolBar;
@property (nonatomic, assign) NSUInteger columnsSection;
@end

@implementation FlashBuyProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(FlashBuyProductDetailData *)data {
    _data = data;
    [self relodData];
}

- (void)relodData {
    [self setupSections];
    self.toolBar.data = self.data;
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 66;
    tableView.estimatedSectionHeaderHeight = 46;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerHeader];
    [self registerCells];
}

- (void)registerHeader {
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailColumnsHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:ColumnsHeaderID];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailBuyNoticeTitleCell" bundle:nil] forCellReuseIdentifier:BuyNoticeTitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailColumnsCell" bundle:nil] forCellReuseIdentifier:ColumnsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailCommentCell" bundle:nil] forCellReuseIdentifier:CommentCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailCommentMoreCell" bundle:nil] forCellReuseIdentifier:CommentMoreCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailCommentEmptyCell" bundle:nil] forCellReuseIdentifier:CommentEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailContentCell" bundle:nil] forCellReuseIdentifier:ContentCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailInfoCell" bundle:nil] forCellReuseIdentifier:InfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailPriceCell" bundle:nil] forCellReuseIdentifier:PriceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailRuleCell" bundle:nil] forCellReuseIdentifier:RuleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailRuleTitleCell" bundle:nil] forCellReuseIdentifier:RuleTitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailStoreCell" bundle:nil] forCellReuseIdentifier:StoreCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailStoreEmptyCell" bundle:nil] forCellReuseIdentifier:StoreEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailWebEmptyCell" bundle:nil] forCellReuseIdentifier:WebEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FlashBuyProductDetailSectionEmptyCell" bundle:nil] forCellReuseIdentifier:SectionEmptyCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.data.narrowImg.count>0) {
        FlashBuyProductDetailBannerCell *bannerCell = [self cellWithID:BannerCellID];
        if (bannerCell) [section01 addObject:bannerCell];
    }
    if (self.data) {
        FlashBuyProductDetailInfoCell *infoCell = [self cellWithID:InfoCellID];
        if (infoCell) [section01 addObject:infoCell];
    }
    if (self.data.priceConfigs.count>0) {
        FlashBuyProductDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
        if (progressCell) [section01 addObject:progressCell];
    }
    if (self.data) {
        FlashBuyProductDetailPriceCell *priceCell = [self cellWithID:PriceCellID];
        if (priceCell) [section01 addObject:priceCell];
    }
    if (section01.count>0) {
        FlashBuyProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        sectionEmptyCell.sectionHeight = 10;
        if (sectionEmptyCell) [section01 addObject:sectionEmptyCell];
    }
    if (section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if ([self.data.flowLinkUrl isNotNull]) {
        FlashBuyProductDetailRuleTitleCell *ruleTitleCell = [self cellWithID:RuleTitleCellID];
        if (ruleTitleCell) [section02 addObject:ruleTitleCell];
    }
    if ([self.data.flowImg isNotNull]) {
        FlashBuyProductDetailRuleCell *ruleCell = [self cellWithID:RuleCellID];
        if (ruleCell) [section02 addObject:ruleCell];
    }
    if (section02.count>0) {
        FlashBuyProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        sectionEmptyCell.sectionHeight = 10;
        if (sectionEmptyCell) [section02 addObject:sectionEmptyCell];
    }
    if (section02.count>0) [sections addObject:section02];
    
    
    if ([self.data.content isNotNull]) {
        NSMutableArray *section03 = [NSMutableArray array];
        FlashBuyProductDetailContentCell *contentCell = [self cellWithID:ContentCellID];
        if (contentCell) [section03 addObject:contentCell];
        if (section03.count>0) {
            FlashBuyProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section03 addObject:sectionEmptyCell];
        }
        if (section03.count>0) [sections addObject:section03];
    }
    
    if (self.data.buyNotice.count>0) {
        NSMutableArray *section04 = [NSMutableArray array];
        FlashBuyProductDetailBuyNoticeTitleCell *buyNoticeTitleCell = [self cellWithID:BuyNoticeTitleCellID];
        if (buyNoticeTitleCell) [section04 addObject:buyNoticeTitleCell];
        [self.data.buyNotice enumerateObjectsUsingBlock:^(FlashBuyProductDetailBuyNotice * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FlashBuyProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell) [section04 addObject:buyNoticeEmptyCell];
            FlashBuyProductDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
            buyNoticeElementCell.buyNotice = obj;
            if (buyNoticeElementCell) [section04 addObject:buyNoticeElementCell];
        }];
        FlashBuyProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
        if (buyNoticeEmptyCell) [section04 addObject:buyNoticeEmptyCell];
        if (section04.count>0) {
            FlashBuyProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section04 addObject:sectionEmptyCell];
        }
        if (section04.count>0) [sections addObject:section04];
    }
    
    if (self.data) {
        NSMutableArray *section05 = [NSMutableArray array];
        //FlashBuyProductDetailColumnsCell *columnsCell = [self cellWithID:ColumnsCellID];
        //if (columnsCell) [section05 addObject:columnsCell];
        self.columnsSection = sections.count;
        switch (self.data.showType) {
            case FlashBuyProductDetailShowTypeDetail:
            {
                if ([self.data.detailUrl isNotNull]) {
                    FlashBuyProductDetailWebCell *webCell = [self cellWithID:WebCellID];
                    if (webCell) [section05 addObject:webCell];
                }else{
                    FlashBuyProductDetailWebEmptyCell *webEmptyCell = [self cellWithID:WebEmptyCellID];
                    if (webEmptyCell) [section05 addObject:webEmptyCell];
                }
            }
                break;
            case FlashBuyProductDetailShowTypeStore:
            {
                if (self.data.store.count>0) {
                    [self.data.store enumerateObjectsUsingBlock:^(FlashBuyProductDetailStore * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        FlashBuyProductDetailStoreCell *storeCell = [self cellWithID:StoreCellID];
                        storeCell.store = obj;
                        if (storeCell) [section05 addObject:storeCell];
                    }];
                }else {
                    FlashBuyProductDetailStoreEmptyCell *storeEmptyCell = [self cellWithID:StoreEmptyCellID];
                    if (storeEmptyCell) [section05 addObject:storeEmptyCell];
                }
            }
                break;
            case FlashBuyProductDetailShowTypeComment:
            {
                if (self.data.commentList.count>0) {
                    [self.data.commentList enumerateObjectsUsingBlock:^(FlashBuyProductDetailCommentListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        FlashBuyProductDetailCommentCell *commentCell = [self cellWithID:CommentCellID];
                        commentCell.comment = obj;
                        if (commentCell) [section05 addObject:commentCell];
                    }];
                    FlashBuyProductDetailCommentMoreCell *commentMoreCell = [self cellWithID:CommentMoreCellID];
                    if (commentMoreCell) [section05 addObject:commentMoreCell];
                }else{
                    FlashBuyProductDetailCommentEmptyCell *commentEmptyCell = [self cellWithID:CommentEmptyCellID];
                    if (commentEmptyCell) [section05 addObject:commentEmptyCell];
                }
            }
                break;
            default:
                break;
        }
        if (section05.count>0) {
            FlashBuyProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 38;
            if (sectionEmptyCell) [section05 addObject:sectionEmptyCell];
        }
        if (section05.count>0) [sections addObject:section05];
    }
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

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
    if (section == self.columnsSection) {
        return 46;
    }else{
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.columnsSection) {
        FlashBuyProductDetailColumnsHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ColumnsHeaderID];
        header.data = self.data;
        WeakSelf(self);
        header.actionBlock = ^{
            StrongSelf(self);
            [self relodData];
        };
        return header;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<FlashBuyProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            FlashBuyProductDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark FlashBuyProductDetailBaseCellDelegate

- (void)flashBuyProductDetailBaseCell:(FlashBuyProductDetailBaseCell *)cell actionType:(FlashBuyProductDetailBaseCellActionType)type vlaue:(id)value {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailView:actionType:value:)]) {
        [self.delegate flashBuyProductDetailView:self actionType:(FlashBuyProductDetailViewActionType)type value:value];
    }
    switch (type) {
        case FlashBuyProductDetailBaseCellActionTypeChangeShowType:
        case FlashBuyProductDetailBaseCellActionTypeWebLoadFinish:
        {
            [self relodData];
        }
            break;
        default:
            break;
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    FlashBuyProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"FlashBuyProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kFlashBuyProductDetailToolBarH, SCREEN_WIDTH, kFlashBuyProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark FlashBuyProductDetailToolBarDelegate

- (void)flashBuyProductDetailToolBar:(FlashBuyProductDetailToolBar *)toolBar actionType:(FlashBuyProductDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailView:actionType:value:)]) {
        [self.delegate flashBuyProductDetailView:self actionType:(FlashBuyProductDetailViewActionType)type value:value];
    }
}


@end
