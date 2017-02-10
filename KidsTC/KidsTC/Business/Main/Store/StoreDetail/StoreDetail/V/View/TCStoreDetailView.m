//
//  TCStoreDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailView.h"
#import "NSString+Category.h"

#import "TCStoreDetailColumnHeader.h"

#import "TCStoreDetailActivityPackageCell.h"
#import "TCStoreDetailActivityPackageMoreCell.h"
#import "TCStoreDetailActivityPackageTitleCell.h"
#import "TCStoreDetailAddressCell.h"
#import "TCStoreDetailBaseCell.h"
#import "TCStoreDetailCommentEmptyCell.h"
#import "TCStoreDetailCommentCell.h"
#import "TCStoreDetailCommentTitleCell.h"
#import "TCStoreDetailCouponCell.h"
#import "TCStoreDetailCouponMoreCell.h"
#import "TCStoreDetailCouponTitleCell.h"
#import "TCStoreDetailHeaderCell.h"
#import "TCStoreDetailMoreStoreCell.h"
#import "TCStoreDetailMoreStoreTitleCell.h"
#import "TCStoreDetailNearbyFacilitiesCell.h"
#import "TCStoreDetailNearbyFacilitiesTitleCell.h"
#import "TCStoreDetailNearbyPackageCell.h"
#import "TCStoreDetailNearbyPackageTitleCell.h"
#import "TCStoreDetailPreferentialPackageCell.h"
#import "TCStoreDetailPreferentialPackageMoreCell.h"
#import "TCStoreDetailPreferentialPackageTitleCell.h"
#import "TCStoreDetailSectionEmptyCell.h"
#import "TCStoreDetailWebCell.h"

#import "TCStoreDetailToolBar.h"

static NSString *const ColumnHeaderID = @"TCStoreDetailColumnHeader";

static NSString *const ActivityPackageCellID = @"TCStoreDetailActivityPackageCell";
static NSString *const ActivityPackageMoreCellID = @"TCStoreDetailActivityPackageMoreCell";
static NSString *const ActivityPackageTitleCellID = @"TCStoreDetailActivityPackageTitleCell";
static NSString *const AddressCellID = @"TCStoreDetailAddressCell";
static NSString *const BaseCellID = @"TCStoreDetailBaseCell";
static NSString *const CommentEmptyCellID = @"TCStoreDetailCommentEmptyCell";
static NSString *const CommentCellID = @"TCStoreDetailCommentCell";
static NSString *const CommentTitleCellID = @"TCStoreDetailCommentTitleCell";
static NSString *const CouponCellID = @"TCStoreDetailCouponCell";
static NSString *const CouponMoreCellID = @"TCStoreDetailCouponMoreCell";
static NSString *const CouponTitleCellID = @"TCStoreDetailCouponTitleCell";
static NSString *const HeaderCellID = @"TCStoreDetailHeaderCell";
static NSString *const MoreStoreCellID = @"TCStoreDetailMoreStoreCell";
static NSString *const MoreStoreTitleCellID = @"TCStoreDetailMoreStoreTitleCell";
static NSString *const NearbyFacilitiesCellID = @"TCStoreDetailNearbyFacilitiesCell";
static NSString *const NearbyFacilitiesTitleCellID = @"TCStoreDetailNearbyFacilitiesTitleCell";
static NSString *const NearbyPackageCellID = @"TCStoreDetailNearbyPackageCell";
static NSString *const NearbyPackageTitleCellID = @"TCStoreDetailNearbyPackageTitleCell";
static NSString *const PreferentialPackageCellID = @"TCStoreDetailPreferentialPackageCell";
static NSString *const PreferentialPackageMoreCellID = @"TCStoreDetailPreferentialPackageMoreCell";
static NSString *const PreferentialPackageTitleCellID = @"TCStoreDetailPreferentialPackageTitleCell";
static NSString *const SectionEmptyCellID = @"TCStoreDetailSectionEmptyCell";
static NSString *const WebCellID = @"TCStoreDetailWebCell";

@interface TCStoreDetailView ()<UITableViewDelegate,UITableViewDataSource,TCStoreDetailColumnHeaderDelegate,TCStoreDetailBaseCellDelegate,TCStoreDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<TCStoreDetailBaseCell *> *> *sections;
@property (nonatomic, strong) TCStoreDetailToolBar *toolBar;
@property (nonatomic, strong) TCStoreDetailColumnHeader *header;
@end

@implementation TCStoreDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(TCStoreDetailData *)data {
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
    [self.tableView registerNib:[UINib nibWithNibName:@"TCStoreDetailColumnHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:ColumnHeaderID];
}

- (void)registerCells {
    [self registerCell:@"TCStoreDetailActivityPackageCell" cellId:ActivityPackageCellID];
    [self registerCell:@"TCStoreDetailActivityPackageMoreCell" cellId:ActivityPackageMoreCellID];
    [self registerCell:@"TCStoreDetailActivityPackageTitleCell" cellId:ActivityPackageTitleCellID];
    [self registerCell:@"TCStoreDetailAddressCell" cellId:AddressCellID];
    [self registerCell:@"TCStoreDetailBaseCell" cellId:BaseCellID];
    [self registerCell:@"TCStoreDetailCommentEmptyCell" cellId:CommentEmptyCellID];
    [self registerCell:@"TCStoreDetailCommentCell" cellId:CommentCellID];
    [self registerCell:@"TCStoreDetailCommentTitleCell" cellId:CommentTitleCellID];
    [self registerCell:@"TCStoreDetailCouponCell" cellId:CouponCellID];
    [self registerCell:@"TCStoreDetailCouponMoreCell" cellId:CouponMoreCellID];
    [self registerCell:@"TCStoreDetailCouponTitleCell" cellId:CouponTitleCellID];
    [self registerCell:@"TCStoreDetailHeaderCell" cellId:HeaderCellID];
    [self registerCell:@"TCStoreDetailMoreStoreCell" cellId:MoreStoreCellID];
    [self registerCell:@"TCStoreDetailMoreStoreTitleCell" cellId:MoreStoreTitleCellID];
    [self registerCell:@"TCStoreDetailNearbyFacilitiesCell" cellId:NearbyFacilitiesCellID];
    [self registerCell:@"TCStoreDetailNearbyFacilitiesTitleCell" cellId:NearbyFacilitiesTitleCellID];
    [self registerCell:@"TCStoreDetailNearbyPackageCell" cellId:NearbyPackageCellID];
    [self registerCell:@"TCStoreDetailNearbyPackageTitleCell" cellId:NearbyPackageTitleCellID];
    [self registerCell:@"TCStoreDetailPreferentialPackageCell" cellId:PreferentialPackageCellID];
    [self registerCell:@"TCStoreDetailPreferentialPackageMoreCell" cellId:PreferentialPackageMoreCellID];
    [self registerCell:@"TCStoreDetailPreferentialPackageTitleCell" cellId:PreferentialPackageTitleCellID];
    [self registerCell:@"TCStoreDetailSectionEmptyCell" cellId:SectionEmptyCellID];
    [self registerCell:@"TCStoreDetailWebCell" cellId:WebCellID];
}

- (void)registerCell:(NSString *)name cellId:(NSString *)cellId {
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:cellId];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    if (self.data.storeBase) {
        NSMutableArray *section00 = [NSMutableArray new];
        TCStoreDetailHeaderCell *headerCell = [self cellWithID:HeaderCellID];
        if (headerCell) [section00 addObject:headerCell];
        TCStoreDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if (addressCell) [section00 addObject:addressCell];
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section00 addObject:sectionEmptyCell];
        if (section00.count>0) [sections addObject:section00];
    }
    
    TCStoreDetailProductPackage *productPackage = self.data.productPackage;
    NSArray<TCStoreDetailProductPackageItem *> *products = productPackage.products;
    NSUInteger productsCount = products.count;
    if (productsCount>0) {
        NSMutableArray *section01 = [NSMutableArray new];
        TCStoreDetailPreferentialPackageTitleCell *preferentialPackageTitleCell = [self cellWithID:PreferentialPackageTitleCellID];
        if (preferentialPackageTitleCell) [section01 addObject:preferentialPackageTitleCell];
        NSUInteger showCount = productsCount;
        if (productsCount>3 && !productPackage.showMore) showCount = 3;
        for (NSUInteger i = 0; i<showCount; i++) {
            TCStoreDetailPreferentialPackageCell *preferentialPackageCell = [self cellWithID:PreferentialPackageCellID];
            preferentialPackageCell.index = i;
            if (preferentialPackageCell) [section01 addObject:preferentialPackageCell];
        }
        if (productsCount>3 && !productPackage.showMore) {
            TCStoreDetailPreferentialPackageMoreCell *preferentialPackageMoreCell = [self cellWithID:PreferentialPackageMoreCellID];
            if (preferentialPackageMoreCell) [section01 addObject:preferentialPackageMoreCell];
        }
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section01 addObject:sectionEmptyCell];
        if (section01.count>0) [sections addObject:section01];
    }
    
    NSArray<NSString *> *coupons = self.data.coupons;
    NSUInteger couponsCount = coupons.count;
    if (couponsCount>0) {
        NSMutableArray *section02 = [NSMutableArray new];
        TCStoreDetailCouponTitleCell *couponTitleCell = [self cellWithID:CouponTitleCellID];
        if (couponTitleCell) [section02 addObject:couponTitleCell];
        TCStoreDetailCouponCell *couponCell = [self cellWithID:CouponCellID];
        if (couponCell) [section02 addObject:couponCell];
        if (couponsCount>3) {
            TCStoreDetailCouponMoreCell *couponMoreCell = [self cellWithID:CouponMoreCellID];
            if (couponMoreCell) [section02 addObject:couponMoreCell];
        }
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section02 addObject:sectionEmptyCell];
        if (section02.count>0) [sections addObject:section02];
    }
    
    TCStoreDetailMoreProductPackage *moreProductPackage = self.data.moreProductPackage;
    NSArray<TCStoreDetailProductPackageItem *> *moreProducts = moreProductPackage.products;
    NSUInteger moreProductsCount = moreProducts.count;
    if (moreProductsCount>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        TCStoreDetailActivityPackageTitleCell *activityPackageTitleCell = [self cellWithID:ActivityPackageTitleCellID];
        if (activityPackageTitleCell) [section03 addObject:activityPackageTitleCell];
        
        NSUInteger showCount = moreProductsCount>4?4:moreProductsCount;
        for (NSUInteger i = 0; i<showCount; i++) {
            TCStoreDetailActivityPackageCell *activityPackageCell = [self cellWithID:ActivityPackageCellID];
            activityPackageCell.index = i;
            if (activityPackageCell) [section03 addObject:activityPackageCell];
        }
        if (moreProductsCount>4) {
            TCStoreDetailActivityPackageMoreCell *activityPackageMoreCell = [self cellWithID:ActivityPackageMoreCellID];
            if (activityPackageMoreCell) [section03 addObject:activityPackageMoreCell];
        }
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section03 addObject:sectionEmptyCell];
        if (section03.count>0) [sections addObject:section03];
    }
    
    NSMutableArray *sectionColumn = [NSMutableArray new];
    
    NSString *detailUrl = self.data.storeBase.detailUrl;
    if ([detailUrl isNotNull]) {
        NSMutableArray *section04 = [NSMutableArray new];
        TCStoreDetailWebCell *webCell = [self cellWithID:WebCellID];
        if (webCell) [section04 addObject:webCell];
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section04 addObject:sectionEmptyCell];
        if (section04.count>0) {
            [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn *obj, NSUInteger idx, BOOL *stop) {
                if (obj.type == TCStoreDetailColumnColumnTypeWebDetail) {
                    obj.indexPath = [NSIndexPath indexPathForRow:sectionColumn.count inSection:sections.count];
                }
            }];
            [sectionColumn addObjectsFromArray:section04];
        }
    }
    
    NSArray<TCStoreDetailCommentItem *> *comments = self.data.comments;
    NSUInteger commentsCount = comments.count;
    NSMutableArray *section05 = [NSMutableArray new];
    TCStoreDetailCommentTitleCell *commentTitleCell = [self cellWithID:CommentTitleCellID];
    if (commentTitleCell) [section05 addObject:commentTitleCell];
    if (commentsCount>0) {
        NSUInteger showCount = commentsCount>2?2:commentsCount;
        for (NSUInteger i = 0; i<showCount; i++) {
            TCStoreDetailCommentCell *commentCell = [self cellWithID:CommentCellID];
            commentCell.index = i;
            if (commentCell) [section05 addObject:commentCell];
        }
    }else{
        TCStoreDetailCommentEmptyCell *commentEmptyCell = [self cellWithID:CommentEmptyCellID];
        if (commentEmptyCell) [section05 addObject:commentEmptyCell];
    }
    TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
    if (sectionEmptyCell) [section05 addObject:sectionEmptyCell];
    if (section05.count>0) {
        [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn *obj, NSUInteger idx, BOOL *stop) {
            if (obj.type == TCStoreDetailColumnColumnTypeComment) {
                obj.indexPath = [NSIndexPath indexPathForRow:sectionColumn.count inSection:sections.count];
            }
        }];
        [sectionColumn addObjectsFromArray:section05];
    }
    
    NSArray<TCStoreDetailFacility *> *facilities = self.data.facilities;
    NSUInteger facilitiesCount = facilities.count;
    if (facilitiesCount>0) {
        NSMutableArray *section06 = [NSMutableArray new];
        TCStoreDetailNearbyFacilitiesTitleCell *nearbyFacilitiesTitleCell = [self cellWithID:NearbyFacilitiesTitleCellID];
        if (nearbyFacilitiesTitleCell) [section06 addObject:nearbyFacilitiesTitleCell];
        TCStoreDetailNearbyFacilitiesCell *nearbyFacilitiesCell = [self cellWithID:NearbyFacilitiesCellID];
        if (nearbyFacilitiesCell) [section06 addObject:nearbyFacilitiesCell];
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section06 addObject:sectionEmptyCell];
        if (section06.count>0) {
            [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn *obj, NSUInteger idx, BOOL *stop) {
                if (obj.type == TCStoreDetailColumnColumnTypeFacility) {
                    obj.indexPath = [NSIndexPath indexPathForRow:sectionColumn.count inSection:sections.count];
                }
            }];
            [sectionColumn addObjectsFromArray:section06];
        }
    }
    
    if (sectionColumn.count>0) {
        self.data.columnsSection = sections.count;
        [sections addObject:sectionColumn];
    }
    
    TCStoreDetailNearbyData *nearbyData = self.data.nearbyData;
    
    NSArray<TCStoreDetailNearbyProduct *> *nearProducts = nearbyData.nearProducts;
    NSUInteger nearProductsCount = nearProducts.count;
    if (nearProductsCount>0) {
        NSMutableArray *section07 = [NSMutableArray new];
        TCStoreDetailNearbyPackageTitleCell *nearbyPackageTitleCell = [self cellWithID:NearbyPackageTitleCellID];
        if (nearbyPackageTitleCell) [section07 addObject:nearbyPackageTitleCell];
        for (NSUInteger i = 0; i<nearProductsCount; i++) {
            TCStoreDetailNearbyPackageCell *nearbyPackageCell = [self cellWithID:NearbyPackageCellID];
            nearbyPackageCell.index = i;
            if (nearbyPackageCell) [section07 addObject:nearbyPackageCell];
        }
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section07 addObject:sectionEmptyCell];
        if (section07.count>0) [sections addObject:section07];
    }
    
    NSArray<TCStoreDetailNearbyStore *> *nearStores = nearbyData.nearStores;
    NSUInteger nearStoresCount = nearStores.count;
    if (nearStoresCount>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        TCStoreDetailMoreStoreTitleCell *moreStoreTitleCell = [self cellWithID:MoreStoreTitleCellID];
        if (moreStoreTitleCell) [section08 addObject:moreStoreTitleCell];
        for (NSUInteger i = 0; i<nearProductsCount; i++) {
            TCStoreDetailMoreStoreCell *moreStoreCell = [self cellWithID:MoreStoreCellID];
            moreStoreCell.index = i;
            if (moreStoreCell) [section08 addObject:moreStoreCell];
        }
        TCStoreDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        if (sectionEmptyCell) [section08 addObject:sectionEmptyCell];
        if (section08.count>0) [sections addObject:section08];
    }
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.data.columns.count<1 || !self.data.hasColumn || !self.header) return;
    NSArray<NSIndexPath *> *indexPathsForVisibleRows = [self.tableView indexPathsForVisibleRows];
    if (indexPathsForVisibleRows.count>0) {
        NSIndexPath *firstIndexPath = indexPathsForVisibleRows.firstObject;
        [self.data.columns enumerateObjectsUsingBlock:^(TCStoreDetailColumn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = obj.indexPath;
            if (indexPath.row == firstIndexPath.row && indexPath.section == firstIndexPath.section) {
                [self.header selectColumn:obj];
            }
        }];
    }
}

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
    if (section == self.data.columnsSection && self.data.hasColumn) {
        return kTCStoreDetailColumnHeaderH;
    }else{
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.data.columnsSection && self.data.hasColumn) {
        TCStoreDetailColumnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ColumnHeaderID];
        header.data = self.data;
        header.delegate = self;
        self.header = header;
        return header;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<TCStoreDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            TCStoreDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark TCStoreDetailColumnHeaderDelegate

- (void)tcStoreDetailColumnHeader:(TCStoreDetailColumnHeader *)haeder didSelectColumn:(TCStoreDetailColumn *)column {
    [self.tableView scrollToRowAtIndexPath:column.indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark NormalProductDetailBaseCellDelegate

- (void)tcStoreDetailBaseCell:(TCStoreDetailBaseCell *)cell actionType:(TCStoreDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailView:actionType:value:)]) {
        [self.delegate tcStoreDetailView:self actionType:(TCStoreDetailViewActionType)type value:value];
    }
    switch (type) {
        case TCStoreDetailViewActionTypePreferentialPackageMore:
        case TCStoreDetailViewActionTypeWebLoadFinish:
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
    TCStoreDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"TCStoreDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kTCStoreDetailToolBarH, SCREEN_WIDTH, kTCStoreDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark NormalProductDetailToolBarDelegate

- (void)tcStoreDetailToolBar:(TCStoreDetailToolBar *)toolBar actionType:(TCStoreDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailView:actionType:value:)]) {
        [self.delegate tcStoreDetailView:self actionType:(TCStoreDetailViewActionType)type value:value];
    }
}

@end
