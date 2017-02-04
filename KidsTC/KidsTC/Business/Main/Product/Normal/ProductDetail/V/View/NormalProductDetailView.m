//
//  NormalProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailView.h"
#import "NSString+Category.h"

#import "NormalProductDetailColumnHeader.h"

#import "NormalProductDetailAddressCell.h"
#import "NormalProductDetailApplyCell.h"
#import "NormalProductDetailBannerCell.h"
#import "NormalProductDetailBaseCell.h"
#import "NormalProductDetailColumnConsultConsultCell.h"
#import "NormalProductDetailColumnConsultEmptyCell.h"
#import "NormalProductDetailColumnConsultMoreCell.h"
#import "NormalProductDetailColumnConsultTipCell.h"
#import "NormalProductDetailColumnWebCell.h"
#import "NormalProductDetailCommentCell.h"
#import "NormalProductDetailCommentMoreCell.h"
#import "NormalProductDetailContactCell.h"
#import "NormalProductDetailContentEleCell.h"
#import "NormalProductDetailContentEleEmptyCell.h"
#import "NormalProductDetailCouponCell.h"
#import "NormalProductDetailDateCell.h"
#import "NormalProductDetailInfoCell.h"
#import "NormalProductDetailJoinCell.h"
#import "NormalProductDetailNoticeCell.h"
#import "NormalProductDetailPriceCell.h"
#import "NormalProductDetailRecommendCell.h"
#import "NormalProductDetailSecondKillCell.h"
#import "NormalProductDetailSectionEmptyCell.h"
#import "NormalProductDetailSelectStandardCell.h"
#import "NormalProductDetailStandardCell.h"
#import "NormalProductDetailTitleCell.h"
#import "NormalProductDetailVideoCell.h"
#import "NormalProductDetailVideoTipCell.h"

#import "NormalProductDetailToolBar.h"

static NSString *const ColumnHeaderID = @"NormalProductDetailColumnHeader";

static NSString *const AddressCellID = @"NormalProductDetailAddressCell";
static NSString *const ApplyCellID = @"NormalProductDetailApplyCell";
static NSString *const BannerCellID = @"NormalProductDetailBannerCell";
static NSString *const BaseCellID = @"NormalProductDetailBaseCell";
static NSString *const ColumnConsultConsultCellID = @"NormalProductDetailColumnConsultConsultCell";
static NSString *const ColumnConsultEmptyCellID = @"NormalProductDetailColumnConsultEmptyCell";
static NSString *const ColumnConsultMoreCellID = @"NormalProductDetailColumnConsultMoreCell";
static NSString *const ColumnConsultTipCellID = @"NormalProductDetailColumnConsultTipCell";
static NSString *const ColumnWebCellID = @"NormalProductDetailColumnWebCell";
static NSString *const CommentCellID = @"NormalProductDetailCommentCell";
static NSString *const CommentMoreCellID = @"NormalProductDetailCommentMoreCell";
static NSString *const ContactCellID = @"NormalProductDetailContactCell";
static NSString *const ContentEleCellID = @"NormalProductDetailContentEleCell";
static NSString *const ContentEleEmptyCellID = @"NormalProductDetailContentEleEmptyCell";
static NSString *const CouponCellID = @"NormalProductDetailCouponCell";
static NSString *const DateCellID = @"NormalProductDetailDateCell";
static NSString *const InfoCellID = @"NormalProductDetailInfoCell";
static NSString *const JoinCellID = @"NormalProductDetailJoinCell";
static NSString *const NoticeCellID = @"NormalProductDetailNoticeCell";
static NSString *const PriceCellID = @"NormalProductDetailPriceCell";
static NSString *const RecommendCellID = @"NormalProductDetailRecommendCell";
static NSString *const SecondKillCellID = @"NormalProductDetailSecondKillCell";
static NSString *const SectionEmptyCellID = @"NormalProductDetailSectionEmptyCell";
static NSString *const SelectStandardCellID = @"NormalProductDetailSelectStandardCell";
static NSString *const StandardCellID = @"NormalProductDetailStandardCell";
static NSString *const TitleCellID = @"NormalProductDetailTitleCell";
static NSString *const VideoCellID = @"NormalProductDetailVideoCell";
static NSString *const VideoTipCellID = @"NormalProductDetailVideoTipCell";

@interface NormalProductDetailView ()<UITableViewDelegate,UITableViewDataSource,NormalProductDetailBaseCellDelegate,NormalProductDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<NormalProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) NormalProductDetailToolBar *toolBar;
@property (nonatomic, assign) NSUInteger columnsSection;
@end

@implementation NormalProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(NormalProductDetailData *)data {
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
    [self.tableView registerNib:[UINib nibWithNibName:@"NormalProductDetailColumnHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:ColumnHeaderID];
}

- (void)registerCells {
    [self registerCell:@"NormalProductDetailAddressCell" cellId:AddressCellID];
    [self registerCell:@"NormalProductDetailApplyCell" cellId:ApplyCellID];
    [self registerCell:@"NormalProductDetailBannerCell" cellId:BannerCellID];
    [self registerCell:@"NormalProductDetailBaseCell" cellId:BaseCellID];
    [self registerCell:@"NormalProductDetailColumnConsultConsultCell" cellId:ColumnConsultConsultCellID];
    [self registerCell:@"NormalProductDetailColumnConsultEmptyCell" cellId:ColumnConsultEmptyCellID];
    [self registerCell:@"NormalProductDetailColumnConsultMoreCell" cellId:ColumnConsultMoreCellID];
    [self registerCell:@"NormalProductDetailColumnConsultTipCell" cellId:ColumnConsultTipCellID];
    [self registerCell:@"NormalProductDetailColumnWebCell" cellId:ColumnWebCellID];
    [self registerCell:@"NormalProductDetailCommentCell" cellId:CommentCellID];
    [self registerCell:@"NormalProductDetailCommentMoreCell" cellId:CommentMoreCellID];
    [self registerCell:@"NormalProductDetailContactCell" cellId:ContactCellID];
    [self registerCell:@"NormalProductDetailContentEleCell" cellId:ContentEleCellID];
    [self registerCell:@"NormalProductDetailContentEleEmptyCell" cellId:ContentEleEmptyCellID];
    [self registerCell:@"NormalProductDetailCouponCell" cellId:CouponCellID];
    [self registerCell:@"NormalProductDetailDateCell" cellId:DateCellID];
    [self registerCell:@"NormalProductDetailInfoCell" cellId:InfoCellID];
    [self registerCell:@"NormalProductDetailJoinCell" cellId:JoinCellID];
    [self registerCell:@"NormalProductDetailNoticeCell" cellId:NoticeCellID];
    [self registerCell:@"NormalProductDetailPriceCell" cellId:PriceCellID];
    [self registerCell:@"NormalProductDetailRecommendCell" cellId:RecommendCellID];
    [self registerCell:@"NormalProductDetailSecondKillCell" cellId:SecondKillCellID];
    [self registerCell:@"NormalProductDetailSectionEmptyCell" cellId:SectionEmptyCellID];
    [self registerCell:@"NormalProductDetailSelectStandardCell" cellId:SelectStandardCellID];
    [self registerCell:@"NormalProductDetailStandardCell" cellId:StandardCellID];
    [self registerCell:@"NormalProductDetailTitleCell" cellId:TitleCellID];
    [self registerCell:@"NormalProductDetailVideoCell" cellId:VideoCellID];
    [self registerCell:@"NormalProductDetailVideoTipCell" cellId:VideoTipCellID];
}

- (void)registerCell:(NSString *)name cellId:(NSString *)cellId {
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:cellId];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray new];
    
    NSMutableArray *section00 = [NSMutableArray new];
    if (_data.narrowImg.count>0) {
        NormalProductDetailBannerCell *bannerCell = [self cellWithID:BannerCellID];
        if(bannerCell) [section00 addObject:bannerCell];
    }
    if (_data.priceSort == PriceSortSecKill) {
        NormalProductDetailSecondKillCell *secondKillCell = [self cellWithID:SecondKillCellID];
        if(secondKillCell) [section00 addObject:secondKillCell];
    }
    if (_data) {
        NormalProductDetailInfoCell *infoCell = [self cellWithID:InfoCellID];
        if (infoCell) [section00 addObject:infoCell];
    }
    if (_data.priceSort != PriceSortSecKill) {
        NormalProductDetailPriceCell *priceCell = [self cellWithID:PriceCellID];
        if (priceCell) [section00 addObject:priceCell];
    }
    if ([_data.time.desc isNotNull] && _data.time.times.count>0) {
        NormalProductDetailDateCell *dateCell = [self cellWithID:DateCellID];
        if(dateCell) [section00 addObject:dateCell];
    }
    if (_data.store.count>0 && (_data.placeType != PlaceTypeNone)) {
        NormalProductDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if(addressCell) [section00 addObject:addressCell];
    }
    if (section00.count>0) {
        NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        sectionEmptyCell.sectionHeight = 10;
        if (sectionEmptyCell) [section00 addObject:sectionEmptyCell];
    }
    if (section00.count>0) [sections addObject:section00];
    
    //已选套餐
    if (_data.product_standards.count>1 && _data.isShowProductStandards) {
        NSMutableArray *sectionForSelectStandard = [NSMutableArray array];
        NormalProductDetailTitleCell *titleCellID = [self cellWithID:TitleCellID];
        titleCellID.text = _data.standardTitle;
        if(titleCellID) [sectionForSelectStandard addObject:titleCellID];
        NormalProductDetailSelectStandardCell *selectStandardCell = [self cellWithID:SelectStandardCellID];
        if(selectStandardCell) [sectionForSelectStandard addObject:selectStandardCell];
        if (sectionForSelectStandard.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [sectionForSelectStandard addObject:sectionEmptyCell];
        }
        if (sectionForSelectStandard.count>0) [sections addObject:sectionForSelectStandard];
    }
    
    //content
    [_data.buyNotice enumerateObjectsUsingBlock:^(NormalProductDetailBuyNotice *obj1, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section01 = [NSMutableArray new];
        if ([obj1.title isNotNull]) {
            NormalProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
            titleCell.text = obj1.title;
            if(titleCell) [section01 addObject:titleCell];
        }
        [obj1.notice enumerateObjectsUsingBlock:^(NormalProductDetailNotice *obj2, NSUInteger idx, BOOL *stop) {
            NormalProductDetailContentEleCell *contentEleCell = [self cellWithID:ContentEleCellID];
            contentEleCell.notice = obj2;
            if(contentEleCell) [section01 addObject:contentEleCell];
        }];
        if (obj1.notice.count>0) {
            NormalProductDetailContentEleEmptyCell *contentEleEmptyCell = [self cellWithID:ContentEleEmptyCellID];
            if(contentEleEmptyCell) [section01 addObject:contentEleEmptyCell];
        }
        if (section01.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section01 addObject:sectionEmptyCell];
        }
        if (section01.count>0) [sections addObject:section01];
    }];
    
    //他们已参加
    if (_data.comment.userHeadImgs.count>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        NormalProductDetailJoinCell *joinCell = [self cellWithID:JoinCellID];
        if(joinCell) [section03 addObject:joinCell];
        if (section03.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section03 addObject:sectionEmptyCell];
        }
        if (section03.count>0) [sections addObject:section03];
    }
    
    //video
    VideoPlayVideoRes *productVideoRes = _data.productVideoRes;
    if (productVideoRes.productVideos.count>0) {
        NSMutableArray *videoSection = [NSMutableArray new];
        if ([productVideoRes.productVideoTitle isNotNull]) {
            NormalProductDetailVideoTipCell *videoTipCell = [self cellWithID:VideoTipCellID];
            videoTipCell.title = productVideoRes.productVideoTitle;
            if (videoTipCell) [videoSection addObject:videoTipCell];
        }
        [productVideoRes.productVideos enumerateObjectsUsingBlock:^(VideoPlayVideo *obj, NSUInteger idx, BOOL *stop) {
            NormalProductDetailVideoCell *videoCell = [self cellWithID:VideoCellID];
            videoCell.tag = idx;
            if (videoCell) [videoSection addObject:videoCell];
        }];
        if (videoSection.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [videoSection addObject:sectionEmptyCell];
        }
        if (videoSection.count>0) [sections addObject:videoSection];
    }
    
    //detail
    NSMutableArray *section04 = [NSMutableArray new];
    switch (_data.showType) {
        case NormalProductDetailColumnShowTypeDetail:
        {
            NormalProductDetailColumnWebCell *columnWebCell = [self cellWithID:ColumnWebCellID];
            if (columnWebCell) [section04 addObject:columnWebCell];
        }
            break;
        case NormalProductDetailColumnShowTypeConsult:
        {
            NormalProductDetailColumnConsultTipCell *columnConsultTipCell = [self cellWithID:ColumnConsultTipCellID];
            if (columnConsultTipCell) [section04 addObject:columnConsultTipCell];
            
            NSArray<NormalProductDetailConsultItem *> *consults = self.data.consults;
            if (consults.count<1) {
                NormalProductDetailColumnConsultEmptyCell *columnConsultEmptyCell = [self cellWithID:ColumnConsultEmptyCellID];
                if(columnConsultEmptyCell) [section04 addObject:columnConsultEmptyCell];
            }else{
                [consults enumerateObjectsUsingBlock:^(NormalProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
                    NormalProductDetailColumnConsultConsultCell *columnConsultConsultCell = [self cellWithID:ColumnConsultConsultCellID];
                    columnConsultConsultCell.item = obj;
                    if(columnConsultConsultCell) [section04 addObject:columnConsultConsultCell];
                }];
                NormalProductDetailColumnConsultMoreCell *columnConsultMoreCell = [self cellWithID:ColumnConsultMoreCellID];
                if(columnConsultMoreCell) [section04 addObject:columnConsultMoreCell];
            }
        }
            break;
        default:
            break;
    }
    if (section04.count>0) {
        NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
        sectionEmptyCell.sectionHeight = 10;
        if (sectionEmptyCell) [section04 addObject:sectionEmptyCell];
    }
    if (section04.count>0) {
        self.columnsSection = sections.count;
        [sections addObject:section04];
    }
    
    //套餐明细
    if (_data.product_standards.count>0) {
        NSMutableArray *section05 = [NSMutableArray new];
        NormalProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"套餐明细";
        if(titleCell) [section05 addObject:titleCell];
        [_data.product_standards enumerateObjectsUsingBlock:^(ProductDetailStandard *obj, NSUInteger idx, BOOL *stop) {
            NormalProductDetailStandardCell *standardCell = [self cellWithID:StandardCellID];
            standardCell.index = idx;
            if(standardCell) [section05 addObject:standardCell];
        }];
        if (section05.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section05 addObject:sectionEmptyCell];
        }
        if (section05.count>0) [sections addObject:section05];
    }
    
    //领取优惠券
    if (_data.coupons.count>0 && _data.canProvideCoupon) {
        NSMutableArray *section06 = [NSMutableArray new];
        NormalProductDetailCouponCell *couponCell = [self cellWithID:CouponCellID];
        if(couponCell) [section06 addObject:couponCell];
        if (section06.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section06 addObject:sectionEmptyCell];
        }
        if (section06.count>0) [sections addObject:section06];
    }
    
    //购买须知
    if (_data) {
        NSMutableArray *section07 = [NSMutableArray new];
        NormalProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"购买须知";
        if(titleCell) [section07 addObject:titleCell];
        if (_data.insurance.items.count>0) {
            NormalProductDetailNoticeCell *noticeCell = [self cellWithID:NoticeCellID];
            if(noticeCell) [section07 addObject:noticeCell];
        }
        if (_data.attApply.count>0) {
            [_data.attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
                NormalProductDetailApplyCell *applyCell = [self cellWithID:ApplyCellID];
                applyCell.attStr = obj;
                if(applyCell) [section07 addObject:applyCell];
            }];
        }
        NormalProductDetailContactCell *contactCell = [self cellWithID:ContactCellID];
        if(contactCell) [section07 addObject:contactCell];
        if (section07.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section07 addObject:sectionEmptyCell];
        }
        if (section07.count>0) [sections addObject:section07];
    }
    
    //活动评价
    if (_data.commentList.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        NormalProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"活动评价";
        if(titleCell) [section08 addObject:titleCell];
        [_data.commentList enumerateObjectsUsingBlock:^(NormalProductDetialCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=5) {
                *stop = YES;
            }else{
                NormalProductDetailCommentCell *commentCell = [self cellWithID:CommentCellID];
                commentCell.index = idx;
                if(commentCell) [section08 addObject:commentCell];
            }
        }];
        NormalProductDetailCommentMoreCell *commentMoreCell = [self cellWithID:CommentMoreCellID];
        if(commentMoreCell) [section08 addObject:commentMoreCell];
        if (section08.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 10;
            if (sectionEmptyCell) [section08 addObject:sectionEmptyCell];
        }
        if (section08.count>0) [sections addObject:section08];
    }
    
    if (_data.recommends.count>0) {
        NSMutableArray *section09 = [NSMutableArray new];
        NormalProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"为您推荐";
        if(titleCell) [section09 addObject:titleCell];
        [_data.recommends enumerateObjectsUsingBlock:^(RecommendProduct *obj, NSUInteger idx, BOOL *stop) {
            NormalProductDetailRecommendCell *recommendCell = [self cellWithID:RecommendCellID];
            recommendCell.index = idx;
            if(recommendCell) [section09 addObject:recommendCell];
        }];
        if (section09.count>0) {
            NormalProductDetailSectionEmptyCell *sectionEmptyCell = [self cellWithID:SectionEmptyCellID];
            sectionEmptyCell.sectionHeight = 38;
            if (sectionEmptyCell) [section09 addObject:sectionEmptyCell];
        }
        if (section09.count>0) [sections addObject:section09];
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
        return kNormalProductDetailColumnHeaderH;
    }else{
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == self.columnsSection) {
        NormalProductDetailColumnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ColumnHeaderID];
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
        NSArray<NormalProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            NormalProductDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark NormalProductDetailBaseCellDelegate

- (void)normalProductDetailBaseCell:(NormalProductDetailBaseCell *)cell actionType:(NormalProductDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailView:actionType:value:)]) {
        [self.delegate normalProductDetailView:self actionType:(NormalProductDetailViewActionType)type value:value];
    }
    switch (type) {
        case NormalProductDetailBaseCellActionTypeOpenWebView:
        case NormalProductDetailBaseCellActionTypeWebViewFinishLoad:
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
    NormalProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"NormalProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kNormalProductDetailToolBarH, SCREEN_WIDTH, kNormalProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark NormalProductDetailToolBarDelegate

- (void)normalProductDetailToolBar:(NormalProductDetailToolBar *)toolBar actionType:(NormalProductDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailView:actionType:value:)]) {
        [self.delegate normalProductDetailView:self actionType:(NormalProductDetailViewActionType)type value:value];
    }
}

@end
