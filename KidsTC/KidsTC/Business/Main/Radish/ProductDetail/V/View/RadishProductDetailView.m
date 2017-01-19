//
//  RadishProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailView.h"
#import "NSString+Category.h"
#import "Colours.h"

#import "RadishProductDetailBaseCell.h"
#import "RadishProductDetailBannerCell.h"
#import "RadishProductDetailInfoCell.h"
#import "RadishProductDetailPriceCell.h"
#import "RadishProductDetailDateCell.h"
#import "RadishProductDetailPlaceCell.h"
#import "RadishProductDetailPlaceCountCell.h"
#import "RadishProductDetailTitleCell.h"
#import "RadishProductDetailBuyNoticeElementCell.h"
#import "RadishProductDetailBuyNoticeEmptyCell.h"
#import "RadishProductDetailJoinCell.h"
#import "RadishProductDetailTwoColumnWebViewCell.h"
#import "RadishProductDetailTwoColumnConsultTipCell.h"
#import "RadishProductDetailTwoColumnConsultEmptyCell.h"
#import "RadishProductDetailTwoColumnConsultConsultCell.h"
#import "RadishProductDetailTwoColumnConsultMoreCell.h"
#import "RadishProductDetailStandardCell.h"
#import "RadishProductDetailNoticeCell.h"
#import "RadishProductDetailApplyCell.h"
#import "RadishProductDetailContactCell.h"
#import "RadishProductDetailCommentCell.h"
#import "RadishProductDetailCommentMoreCell.h"
#import "RadishProductDetailRecommendCell.h"
#import "RadishProductDetailVideoCell.h"
#import "RadishProductDetailVideoTipCell.h"

#import "RadishProductDetailTwoColumnToolBar.h"
#import "RadishProductDetailToolBar.h"

static NSString *const BaseCellID = @"RadishProductDetailBaseCell";
static NSString *const BannerCellID = @"RadishProductDetailBannerCell";
static NSString *const InfoCellID = @"RadishProductDetailInfoCell";
static NSString *const PriceCellID = @"RadishProductDetailPriceCell";
static NSString *const DateCellID = @"RadishProductDetailDateCell";
static NSString *const PlaceCellID = @"RadishProductDetailPlaceCell";
static NSString *const PlaceCountCellID = @"RadishProductDetailPlaceCountCell";
static NSString *const TitleCellID = @"RadishProductDetailTitleCell";
static NSString *const BuyNoticeElementCellID = @"RadishProductDetailBuyNoticeElementCell";
static NSString *const BuyNoticeEmptyCellID = @"RadishProductDetailBuyNoticeEmptyCell";
static NSString *const JoinCellID = @"RadishProductDetailJoinCell";
static NSString *const TwoColumnWebViewCellID = @"RadishProductDetailTwoColumnWebViewCell";
static NSString *const TwoColumnConsultTipCellID = @"RadishProductDetailTwoColumnConsultTipCell";
static NSString *const TwoColumnConsultEmptyCellID = @"RadishProductDetailTwoColumnConsultEmptyCell";
static NSString *const TwoColumnConsultConsultCellID = @"RadishProductDetailTwoColumnConsultConsultCell";
static NSString *const TwoColumnConsultMoreCellID = @"RadishProductDetailTwoColumnConsultMoreCell";
static NSString *const StandardCellID = @"RadishProductDetailStandardCell";
static NSString *const NoticeCellID = @"RadishProductDetailNoticeCell";
static NSString *const ApplyCellID = @"RadishProductDetailApplyCell";
static NSString *const ContactCellID = @"RadishProductDetailContactCell";
static NSString *const CommentCellID = @"RadishProductDetailCommentCell";
static NSString *const CommentMoreCellID = @"RadishProductDetailCommentMoreCell";
static NSString *const RecommendCellID = @"RadishProductDetailRecommendCell";
static NSString *const VideoCellID = @"RadishProductDetailVideoCell";
static NSString *const VideoTipCellID = @"RadishProductDetailVideoTipCell";

@interface RadishProductDetailView ()<UITableViewDelegate,UITableViewDataSource,RadishProductDetailBaseCellDelegate,RadishProductDetailTwoColumnToolBarDelegate,RadishProductDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<RadishProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) RadishProductDetailTwoColumnToolBar *twoColumnToolBar;
@property (nonatomic, strong) RadishProductDetailToolBar *toolBar;
@property (nonatomic, assign) NSUInteger twoColumnSectionUsed;
@property (nonatomic, weak  ) RadishProductDetailBaseCell *twoColumnCell;
@end

@implementation RadishProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupTwoColumnToolBar];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(RadishProductDetailData *)data {
    _data = data;
    
    self.twoColumnToolBar.data = self.data;
    self.toolBar.data = self.data;
    
    [self setupSections];
    [self reload];
}

- (void)reload {
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:self.tableView];
    });
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 66;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailInfoCell" bundle:nil] forCellReuseIdentifier:InfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailPriceCell" bundle:nil] forCellReuseIdentifier:PriceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailDateCell" bundle:nil] forCellReuseIdentifier:DateCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailPlaceCell" bundle:nil] forCellReuseIdentifier:PlaceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailPlaceCountCell" bundle:nil] forCellReuseIdentifier:PlaceCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailJoinCell" bundle:nil] forCellReuseIdentifier:JoinCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnWebViewCell" bundle:nil] forCellReuseIdentifier:TwoColumnWebViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultTipCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultEmptyCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultConsultCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultConsultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultMoreCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultMoreCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailStandardCell" bundle:nil] forCellReuseIdentifier:StandardCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailNoticeCell" bundle:nil] forCellReuseIdentifier:NoticeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailApplyCell" bundle:nil] forCellReuseIdentifier:ApplyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailContactCell" bundle:nil] forCellReuseIdentifier:ContactCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailCommentCell" bundle:nil] forCellReuseIdentifier:CommentCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailCommentMoreCell" bundle:nil] forCellReuseIdentifier:CommentMoreCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailRecommendCell" bundle:nil] forCellReuseIdentifier:RecommendCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailVideoCell" bundle:nil] forCellReuseIdentifier:VideoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailVideoTipCell" bundle:nil] forCellReuseIdentifier:VideoTipCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (self.data.narrowImg.count>0) {
        RadishProductDetailBannerCell *bannerCell = [self cellWithID:BannerCellID];
        if (bannerCell) [section01 addObject:bannerCell];
    }
    RadishProductDetailInfoCell *infoCell = [self cellWithID:InfoCellID];
    if (infoCell) [section01 addObject:infoCell];
    RadishProductDetailPriceCell *priceCell = [self cellWithID:PriceCellID];
    if (priceCell) [section01 addObject:priceCell];
    if (self.data.time) {
        RadishProductDetailDateCell *dateCell = [self cellWithID:DateCellID];
        if (dateCell) [section01 addObject:dateCell];
    }
    switch (self.data.placeType) {
        case PlaceTypeStore:
        {
            if (self.data.store.count>0) {
                RadishProductDetailPlaceCell *placeCell = [self cellWithID:PlaceCellID];
                if (placeCell) [section01 addObject:placeCell];
            }
            if (self.data.store.count>1) {
                RadishProductDetailPlaceCountCell *placeCountCell = [self cellWithID:PlaceCountCellID];
                if (placeCountCell) [section01 addObject:placeCountCell];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (self.data.place.count>0) {
                RadishProductDetailPlaceCell *placeCell = [self cellWithID:PlaceCellID];
                if (placeCell) [section01 addObject:placeCell];
            }
            if (self.data.place.count>1) {
                RadishProductDetailPlaceCountCell *placeCountCell = [self cellWithID:PlaceCountCellID];
                if (placeCountCell) [section01 addObject:placeCountCell];
            }
        }
            break;
        default:
            break;
    }
    if(section01.count>0) [sections addObject:section01];
    
    //content
    NSArray<RadishProductDetailBuyNotice *> *buyNotice = self.data.buyNotice;
    [buyNotice enumerateObjectsUsingBlock:^(RadishProductDetailBuyNotice *obj1, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section02 = [NSMutableArray new];
        if ([obj1.title isNotNull]) {
            RadishProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
            titleCell.text = obj1.title;
            [section02 addObject:titleCell];
        }
        [obj1.notice enumerateObjectsUsingBlock:^(RadishProductDetailNotice *obj2, NSUInteger idx, BOOL *stop) {
            RadishProductDetailBuyNoticeEmptyCell *emptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (emptyCell) [section02 addObject:emptyCell];
            RadishProductDetailBuyNoticeElementCell *elementCell = [self cellWithID:BuyNoticeElementCellID];
            elementCell.notice = obj2;
            if (elementCell) [section02 addObject:elementCell];
        }];
        if (obj1.notice.count>0) {
            RadishProductDetailBuyNoticeEmptyCell *emptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (emptyCell) [section02 addObject:emptyCell];
        }
        if (section02.count>0) [sections addObject:section02];
    }];

    //他们已参加
    if (self.data.comment.userHeadImgs.count>0) {
        NSMutableArray *section03 = [NSMutableArray new];
        RadishProductDetailJoinCell *joinCell = [self cellWithID:JoinCellID];
        if (joinCell) [section03 addObject:joinCell];
        if (section03.count>0) [sections addObject:section03];
    }
    
    //video
    VideoPlayVideoRes *productVideoRes = self.data.productVideoRes;
    if (productVideoRes.productVideos.count>0) {
        NSMutableArray *videoSection = [NSMutableArray new];
        if ([productVideoRes.productVideoTitle isNotNull]) {
            RadishProductDetailVideoTipCell *videoTipCell = [self cellWithID:VideoTipCellID];
            videoTipCell.title = productVideoRes.productVideoTitle;
            if (videoTipCell) [videoSection addObject:videoTipCell];
        }
        [productVideoRes.productVideos enumerateObjectsUsingBlock:^(VideoPlayVideo *obj, NSUInteger idx, BOOL *stop) {
            RadishProductDetailVideoCell *videoCell = [self cellWithID:VideoCellID];
            videoCell.tag = idx;
            if (videoCell) [videoSection addObject:videoCell];
        }];
        if (videoSection.count>0) [sections addObject:videoSection];
    }

    //活动明细、活动咨询
    NSArray<ProductDetailConsultItem *> *consults = self.data.consults;
    NSMutableArray *section04 = [NSMutableArray array];
    switch (self.data.showType) {
        case RadishProductDetailTwoColumnShowTypeDetail:
        {
            RadishProductDetailTwoColumnWebViewCell *webViewCell = [self cellWithID:TwoColumnWebViewCellID];
            if (webViewCell) {
                [section04 addObject:webViewCell];
                self.twoColumnCell = webViewCell;
            }
            
        }
            break;
        case RadishProductDetailTwoColumnShowTypeConsult:
        {
            RadishProductDetailTwoColumnConsultTipCell *consultTipCell = [self cellWithID:TwoColumnConsultTipCellID];
            if (consultTipCell){
                [section04 addObject:consultTipCell];
                self.twoColumnCell = consultTipCell;
            }
            if (consults.count<1) {
                RadishProductDetailTwoColumnConsultEmptyCell *consultEmptyCell = [self cellWithID:TwoColumnConsultEmptyCellID];
                if (consultEmptyCell) [section04 addObject:consultEmptyCell];
            }else{
                [consults enumerateObjectsUsingBlock:^(ProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
                    RadishProductDetailTwoColumnConsultConsultCell *consultConsultCell = [self cellWithID:TwoColumnConsultConsultCellID];
                    consultConsultCell.item = obj;
                    if (consultConsultCell) [section04 addObject:consultConsultCell];
                }];
                RadishProductDetailTwoColumnConsultMoreCell *consultMoreCell = [self cellWithID:TwoColumnConsultMoreCellID];
                if (consultMoreCell) [section04 addObject:consultMoreCell];
            }
        }
            break;
        default:
            break;
    }
    self.twoColumnSectionUsed = sections.count;
    if(section04.count>0) [sections addObject:section04];
    
    //套餐明细
    NSArray<RadishProductDetailStandard *> *product_standards = self.data.product_standards;
    if (product_standards.count>0) {
        NSMutableArray *section05 = [NSMutableArray new];
        RadishProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"其他优惠";
        if (titleCell) [section05 addObject:titleCell];
        [product_standards enumerateObjectsUsingBlock:^(RadishProductDetailStandard *obj, NSUInteger idx, BOOL *stop) {
            RadishProductDetailStandardCell *standardCell = [self cellWithID:StandardCellID];
            standardCell.index = idx;
            if (standardCell) [section05 addObject:standardCell];
        }];
        if (section05.count>0) [sections addObject:section05];
    }
    
    //购买须知
    NSArray<RadishProductDetailInsuranceItem *> *items = self.data.insurance.items;
    NSArray<NSAttributedString *> *attApply = self.data.attApply;
    NSMutableArray *section06 = [NSMutableArray new];
    if (items.count>0 || attApply.count>0) {
        RadishProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"兑换须知";
        if (titleCell) [section06 addObject:titleCell];
        if (items.count>0) {
            RadishProductDetailNoticeCell *noticeCell = [self cellWithID:NoticeCellID];
            if (noticeCell) [section06 addObject:noticeCell];
        }
        [attApply enumerateObjectsUsingBlock:^(NSAttributedString *obj, NSUInteger idx, BOOL *stop) {
            RadishProductDetailApplyCell *applyCell = [self cellWithID:ApplyCellID];
            applyCell.attStr = obj;
            if (applyCell) [section06 addObject:applyCell];
        }];
    }
    RadishProductDetailContactCell *contactCell = [self cellWithID:ContactCellID];
    if (contactCell) [section06 addObject:contactCell];
    if (section06.count>0) [sections addObject:section06];
    
    //活动评价
    NSArray<RadishProductDetailCommentItem *> *commentList = self.data.commentList;
    if (commentList.count>0) {
        NSMutableArray *section07 = [NSMutableArray new];
        RadishProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"活动评价";
        if (titleCell) [section07 addObject:titleCell];
        
        [commentList enumerateObjectsUsingBlock:^(RadishProductDetailCommentItem *obj, NSUInteger idx, BOOL *stop) {
            if (idx>=5) {
                *stop = YES;
            }else{
                RadishProductDetailCommentCell *commentCell = [self cellWithID:CommentCellID];
                commentCell.index = idx;
                if (commentCell) [section07 addObject:commentCell];
            }
        }];
        RadishProductDetailCommentMoreCell *commentMoreCell = [self cellWithID:CommentMoreCellID];
        if (commentMoreCell) [section07 addObject:commentMoreCell];
        if (section07.count>0) [sections addObject:section07];
    }

    //为您推荐
    NSArray<RecommendProduct *> *recommends = self.data.recommends;
    if (recommends.count>0) {
        NSMutableArray *section08 = [NSMutableArray new];
        RadishProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
        titleCell.text = @"为您推荐";
        if (titleCell) [section08 addObject:titleCell];
        [recommends enumerateObjectsUsingBlock:^(RecommendProduct *obj, NSUInteger idx, BOOL *stop) {
            RadishProductDetailRecommendCell *recommendCell = [self cellWithID:RecommendCellID];
            recommendCell.index = idx;
            if (recommendCell) [section08 addObject:recommendCell];
        }];
        if (section08.count>0) [sections addObject:section08];
    }
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    [self setupTwoColumnToolBarFrame:offsetY];
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
    if (section == self.twoColumnSectionUsed) {
        return CGRectGetHeight(_twoColumnToolBar.bounds);
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.sections.count - 1)?38:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<RadishProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishProductDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark RadishProductDetailBaseCellDelegate

- (void)radishProductDetailBaseCell:(RadishProductDetailBaseCell *)cell actionType:(RadishProductDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailView:actionType:value:)]) {
        [self.delegate radishProductDetailView:self actionType:(RadishProductDetailViewActionType)type value:value];
    }
    switch (type) {
        case RadishProductDetailBaseCellActionTypeWebLoadFinish:
        case RadishProductDetailBaseCellActionTypeOpenWebView:
        {
            [self reload];
        }
            break;
        default:
            break;
    }
}

#pragma mark - setupTwoColumnToolBar

- (void)setupTwoColumnToolBar {
    RadishProductDetailTwoColumnToolBar *twoColumnToolBar = [[NSBundle mainBundle] loadNibNamed:@"RadishProductDetailTwoColumnToolBar" owner:self options:nil].firstObject;
    twoColumnToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, kRadishTwoColumnToolBarH);
    twoColumnToolBar.delegate = self;
    [self addSubview:twoColumnToolBar];
    self.twoColumnToolBar = twoColumnToolBar;
}

- (void)setupTwoColumnToolBarFrame:(CGFloat)offsetY {
    CGFloat twoColumnCellY = CGRectGetMinY(self.twoColumnCell.frame);
    if (twoColumnCellY<=0) {
        _twoColumnToolBar.hidden = YES;
    }else{
        CGFloat y = twoColumnCellY - kRadishTwoColumnToolBarH - offsetY;
        if (y<0) y = 0;
        CGRect frame = _twoColumnToolBar.frame;
        frame.origin.y = y;
        _twoColumnToolBar.frame = frame;
        _twoColumnToolBar.hidden = NO;
    }
}

#pragma mark RadishProductDetailTwoColumnToolBarDelegate

- (void)radishProductDetailTwoColumnToolBar:(RadishProductDetailTwoColumnToolBar *)toolBar ationType:(RadishProductDetailTwoColumnShowType)type value:(id)value {
    [self setupSections];
    [self reload];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    RadishProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"RadishProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kRadishProductDetailToolBarH, SCREEN_WIDTH, kRadishProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark RadishProductDetailToolBarDelegate

- (void)radishProductDetailToolBar:(RadishProductDetailToolBar *)toolBar actionType:(RadishProductDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailView:actionType:value:)]) {
        [self.delegate radishProductDetailView:self actionType:(RadishProductDetailViewActionType)type value:value];
    }
}

@end
