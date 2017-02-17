//
//  WolesaleProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailView.h"
#import "NSString+Category.h"
#import "RefreshFooter.h"

#import "WolesaleProductDetailBaseCell.h"
#import "WolesaleProductDetailProgressCell.h"
#import "WolesaleProductDetailProductInfoCell.h"
#import "WolesaleProductDetailRuleTipCell.h"
#import "WolesaleProductDetailJoinTipCell.h"
#import "WolesaleProductDetailJoinCountDownCell.h"
#import "WolesaleProductDetailJoinTeamCell.h"
#import "WolesaleProductDetailJoinCountCell.h"
#import "WolesaleProductDetailTitleCell.h"
#import "WolesaleProductDetailBuyNoticeEmptyCell.h"
#import "WolesaleProductDetailBuyNoticeElementCell.h"
#import "WolesaleProductDetailTimeCell.h"
#import "WolesaleProductDetailAddressCell.h"
#import "WolesaleProductDetailWebCell.h"
#import "WolesaleProductDetailOtherPorductCell.h"
#import "WolesaleProductDetailVideoCell.h"
#import "WolesaleProductDetailVideoTipCell.h"

#import "WolesaleProductDetailV2BannersCell.h"
#import "WolesaleProductDetailV2InfoCell.h"
#import "WolesaleProductDetailV2SaveTipCell.h"
#import "WolesaleProductDetailV2JoinTipCell.h"
#import "WolesaleProductDetailV2JoinTeamCell.h"
#import "WolesaleProductDetailV2JoinCountCell.h"
#import "WolesaleProductDetailV2PlaceCell.h"
#import "WolesaleProductDetailV2PlaceCountCell.h"
#import "WolesaleProductDetailV2OtherProductCell.h"
#import "WolesaleProductDetailV2WebTitleCell.h"

#import "WolesaleProductDetailToolBar.h"

static NSString *const BaseCellID = @"WolesaleProductDetailBaseCell";
static NSString *const ProgressCellID = @"WolesaleProductDetailProgressCell";
static NSString *const ProductInfoCellID = @"WolesaleProductDetailProductInfoCell";
static NSString *const RuleTipCellID = @"WolesaleProductDetailRuleTipCell";
static NSString *const JoinTipCellID = @"WolesaleProductDetailJoinTipCell";
static NSString *const JoinCountDownCellID = @"WolesaleProductDetailJoinCountDownCell";
static NSString *const JoinTeamCellID = @"WolesaleProductDetailJoinTeamCell";
static NSString *const JoinCountCellID = @"WolesaleProductDetailJoinCountCell";
static NSString *const TitleCellID = @"WolesaleProductDetailTitleCell";
static NSString *const BuyNoticeEmptyCellID = @"WolesaleProductDetailBuyNoticeEmptyCell";
static NSString *const BuyNoticeElementCellID = @"WolesaleProductDetailBuyNoticeElementCell";
static NSString *const TimeCellID = @"WolesaleProductDetailTimeCell";
static NSString *const AddressCellID = @"WolesaleProductDetailAddressCell";
static NSString *const WebCellID = @"WolesaleProductDetailWebCell";
static NSString *const OtherPorductCellID = @"WolesaleProductDetailOtherPorductCell";
static NSString *const VideoCellID = @"WolesaleProductDetailVideoCell";
static NSString *const VideoTipCellID = @"WolesaleProductDetailVideoTipCell";
//V2
static NSString *const V2BannersCellID = @"WolesaleProductDetailV2BannersCell";
static NSString *const V2InfoCellID = @"WolesaleProductDetailV2InfoCell";
static NSString *const V2SaveTipCellID = @"WolesaleProductDetailV2SaveTipCell";
static NSString *const V2JoinTipCellID = @"WolesaleProductDetailV2JoinTipCell";
static NSString *const V2JoinTeamCellID = @"WolesaleProductDetailV2JoinTeamCell";
static NSString *const V2JoinCountCellID = @"WolesaleProductDetailV2JoinCountCell";
static NSString *const V2PlaceCellID = @"WolesaleProductDetailV2PlaceCell";
static NSString *const V2PlaceCountCellID = @"WolesaleProductDetailV2PlaceCountCell";
static NSString *const V2OtherProductCellID = @"WolesaleProductDetailV2OtherProductCell";
static NSString *const V2WebTitleCellID = @"WolesaleProductDetailV2WebTitleCell";

@interface WolesaleProductDetailView ()<UITableViewDelegate,UITableViewDataSource,WolesaleProductDetailBaseCellDelegate,WolesaleProductDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<WolesaleProductDetailBaseCell *> *> *sections;

@property (nonatomic, strong) WolesaleProductDetailToolBar *toolBar;
@end

@implementation WolesaleProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(WolesaleProductDetailData *)data {
    _data = data;
    self.toolBar.data = self.data;
    if (data.fightGroupBase.detailV2) {
        [self setupV2Sections];
    }else{
        [self setupSections];
    }
    [self.tableView reloadData];
}

- (void)deailWithUI:(NSInteger)count {
    [self.tableView.mj_footer endRefreshing];
    if (count<1) [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
    
    WeakSelf(self)
    RefreshFooter *footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadMoreStandard];
    }];
    tableView.mj_footer = footer;
}

- (void)loadMoreStandard {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailView:actionType:value:)]) {
        [self.delegate wolesaleProductDetailView:self actionType:WolesaleProductDetailViewActionTypeLoadStandard value:nil];
    }
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailRuleTipCell" bundle:nil] forCellReuseIdentifier:RuleTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinTipCell" bundle:nil] forCellReuseIdentifier:JoinTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinCountDownCell" bundle:nil] forCellReuseIdentifier:JoinCountDownCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinTeamCell" bundle:nil] forCellReuseIdentifier:JoinTeamCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinCountCell" bundle:nil] forCellReuseIdentifier:JoinCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailOtherPorductCell" bundle:nil] forCellReuseIdentifier:OtherPorductCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailVideoCell" bundle:nil] forCellReuseIdentifier:VideoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailVideoTipCell" bundle:nil] forCellReuseIdentifier:VideoTipCellID];
    //V2
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2BannersCell" bundle:nil] forCellReuseIdentifier:V2BannersCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2InfoCell" bundle:nil] forCellReuseIdentifier:V2InfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2SaveTipCell" bundle:nil] forCellReuseIdentifier:V2SaveTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2JoinTipCell" bundle:nil] forCellReuseIdentifier:V2JoinTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2JoinTeamCell" bundle:nil] forCellReuseIdentifier:V2JoinTeamCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2JoinCountCell" bundle:nil] forCellReuseIdentifier:V2JoinCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2PlaceCell" bundle:nil] forCellReuseIdentifier:V2PlaceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2PlaceCountCell" bundle:nil] forCellReuseIdentifier:V2PlaceCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2OtherProductCell" bundle:nil] forCellReuseIdentifier:V2OtherProductCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailV2WebTitleCell" bundle:nil] forCellReuseIdentifier:V2WebTitleCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    WholesaleProductDetailBase *base = self.data.fightGroupBase;
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    WolesaleProductDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section01 addObject:progressCell];
    WolesaleProductDetailProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section01 addObject:productInfoCell];
    WolesaleProductDetailRuleTipCell *ruleTipCell = [self cellWithID:RuleTipCellID];
    if (ruleTipCell) [section01 addObject:ruleTipCell];
    if (base.teams.count>0) {
        WolesaleProductDetailJoinTipCell *joinTipCell = [self cellWithID:JoinTipCellID];
        if (joinTipCell) [section01 addObject:joinTipCell];
    }
    [base.teams enumerateObjectsUsingBlock:^(WholesaleProductDetailTeam *team, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailJoinTeamCell *joinTeamCell = [self cellWithID:JoinTeamCellID];
        joinTeamCell.team = team;
        if (joinTeamCell) [section01 addObject:joinTeamCell];
    }];
    if (base.teamCounts.count>1) {
        WolesaleProductDetailJoinCountCell *joinCountCell = [self cellWithID:JoinCountCellID];
        joinCountCell.tag = WolesaleProductDetailBaseCellActionTypeLoadTeam;
        joinCountCell.counts = base.teamCounts;
        if (joinCountCell) [section01 addObject:joinCountCell];
    }
    if(section01.count>0) [sections addObject:section01];
    
    [base.buyNotice enumerateObjectsUsingBlock:^(WholesaleProductDetailBuyNotice *buyNotice, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section02 = [NSMutableArray array];
        WolesaleProductDetailTitleCell *titleCell_buyNotice = [self cellWithID:TitleCellID];
        titleCell_buyNotice.title = buyNotice.title;
        if (titleCell_buyNotice) [section02 addObject:titleCell_buyNotice];
        [buyNotice.notice enumerateObjectsUsingBlock:^(WholesaleProductDetailNotice *notice, NSUInteger idx, BOOL *stop) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell) [section02 addObject:buyNoticeEmptyCell];
            WolesaleProductDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
            buyNoticeElementCell.notice = notice;
            if (buyNoticeElementCell) [section02 addObject:buyNoticeElementCell];
        }];
        if (buyNotice.notice.count>0) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell_last = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell_last) [section02 addObject:buyNoticeEmptyCell_last];
        }
        if(section02.count>0) [sections addObject:section02];
    }];
    
    //video
    VideoPlayVideoRes *productVideoRes = base.productVideoRes;
    if (productVideoRes.productVideos.count>0) {
        NSMutableArray *videoSection = [NSMutableArray new];
        if ([productVideoRes.productVideoTitle isNotNull]) {
            WolesaleProductDetailVideoTipCell *videoTipCell = [self cellWithID:VideoTipCellID];
            videoTipCell.title = productVideoRes.productVideoTitle;
            if (videoTipCell) [videoSection addObject:videoTipCell];
        }
        [productVideoRes.productVideos enumerateObjectsUsingBlock:^(VideoPlayVideo *obj, NSUInteger idx, BOOL *stop) {
            WolesaleProductDetailVideoCell *videoCell = [self cellWithID:VideoCellID];
            videoCell.tag = idx;
            if (videoCell) [videoSection addObject:videoCell];
        }];
        if (videoSection.count>0) [sections addObject:videoSection];
    }
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (base.productTime || base.store || [base.detailUrl isNotNull]) {
        WolesaleProductDetailTitleCell *titleCell_detail = [self cellWithID:TitleCellID];
        titleCell_detail.title = @"活动详情";
        if (titleCell_detail) [section03 addObject:titleCell_detail];
    }
    if (base.productTime) {
        WolesaleProductDetailTimeCell *timeCell = [self cellWithID:TimeCellID];
        if (timeCell) [section03 addObject:timeCell];
    }
    switch (base.placeType) {
        case PlaceTypeStore:
        {
            if (base.stores.count>0) {
                WolesaleProductDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
                if (addressCell) [section03 addObject:addressCell];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (base.place.count>0) {
                WolesaleProductDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
                if (addressCell) [section03 addObject:addressCell];
            }
        }
            break;
        default:
            break;
    }
    if ([base.detailUrl isNotNull]) {
        WolesaleProductDetailWebCell *webCell = [self cellWithID:WebCellID];
        if (webCell) [section03 addObject:webCell];
    }
    if(section03.count>0) [sections addObject:section03];
    
    NSMutableArray *section04 = [NSMutableArray array];
    if (base.otherProducts.count>0 && [base.otherPackageTitle isNotNull]) {
        WolesaleProductDetailTitleCell *titleCell_otherProduct = [self cellWithID:TitleCellID];
        titleCell_otherProduct.title = base.otherPackageTitle;
        if (titleCell_otherProduct) [section04 addObject:titleCell_otherProduct];
    }
    [base.otherProducts enumerateObjectsUsingBlock:^(WholesaleProductDetailOtherProduct *otherProduct, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailOtherPorductCell *otherPorductCell = [self cellWithID:OtherPorductCellID];
        otherPorductCell.otherProduct = otherProduct;
        if (otherPorductCell) [section04 addObject:otherPorductCell];
    }];

    if(section04.count>0) [sections addObject:section04];
    
    self.sections = [NSArray arrayWithArray:sections];
}

- (void)setupV2Sections {
    
    WholesaleProductDetailBase *base = self.data.fightGroupBase;
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    if (base.detailV2.banners.count>0) {
        WolesaleProductDetailV2BannersCell *V2BannersCell = [self cellWithID:V2BannersCellID];
        if (V2BannersCell) [section01 addObject:V2BannersCell];
    }
    
    WolesaleProductDetailV2InfoCell *V2InfoCell = [self cellWithID:V2InfoCellID];
    if (V2InfoCell) [section01 addObject:V2InfoCell];
    
    WolesaleProductDetailV2SaveTipCell *V2SaveTipCell = [self cellWithID:V2SaveTipCellID];
    if (V2SaveTipCell) [section01 addObject:V2SaveTipCell];
    WolesaleProductDetailRuleTipCell *ruleTipCell = [self cellWithID:RuleTipCellID];
    if (ruleTipCell) [section01 addObject:ruleTipCell];
    if (base.teams.count>0) {
        WolesaleProductDetailV2JoinTipCell *V2JoinTipCell = [self cellWithID:V2JoinTipCellID];
        if (V2JoinTipCell) [section01 addObject:V2JoinTipCell];
    }
    [base.teams enumerateObjectsUsingBlock:^(WholesaleProductDetailTeam *team, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailV2JoinTeamCell *V2JoinTeamCell = [self cellWithID:V2JoinTeamCellID];
        V2JoinTeamCell.team = team;
        if (V2JoinTeamCell) [section01 addObject:V2JoinTeamCell];
    }];
    if (base.teamCounts.count>1) {
        WolesaleProductDetailV2JoinCountCell *V2JoinCountCell = [self cellWithID:V2JoinCountCellID];
        V2JoinCountCell.tag = WolesaleProductDetailBaseCellActionTypeLoadTeam;
        V2JoinCountCell.counts = base.teamCounts;
        if (V2JoinCountCell) [section01 addObject:V2JoinCountCell];
    }
    if (base.buyNotice.count>0) {
        WholesaleProductDetailBuyNotice *buyNotice01 = base.buyNotice.firstObject;
        WolesaleProductDetailTitleCell *titleCell_buyNotice = [self cellWithID:TitleCellID];
        titleCell_buyNotice.title = buyNotice01.title;
        if (titleCell_buyNotice) [section01 addObject:titleCell_buyNotice];
        [buyNotice01.notice enumerateObjectsUsingBlock:^(WholesaleProductDetailNotice *notice, NSUInteger idx, BOOL *stop) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell) [section01 addObject:buyNoticeEmptyCell];
            WolesaleProductDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
            buyNoticeElementCell.notice = notice;
            if (buyNoticeElementCell) [section01 addObject:buyNoticeElementCell];
        }];
        if (buyNotice01.notice.count>0) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell_last = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell_last) [section01 addObject:buyNoticeEmptyCell_last];
        }
    }
    if(section01.count>0) [sections addObject:section01];
    
    [base.buyNotice enumerateObjectsUsingBlock:^(WholesaleProductDetailBuyNotice *buyNotice, NSUInteger idx, BOOL *stop) {
        if (idx>0) {
            NSMutableArray *section02 = [NSMutableArray array];
            WolesaleProductDetailTitleCell *titleCell_buyNotice = [self cellWithID:TitleCellID];
            titleCell_buyNotice.title = buyNotice.title;
            if (titleCell_buyNotice) [section02 addObject:titleCell_buyNotice];
            [buyNotice.notice enumerateObjectsUsingBlock:^(WholesaleProductDetailNotice *notice, NSUInteger idx, BOOL *stop) {
                WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
                if (buyNoticeEmptyCell) [section02 addObject:buyNoticeEmptyCell];
                WolesaleProductDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
                buyNoticeElementCell.notice = notice;
                if (buyNoticeElementCell) [section02 addObject:buyNoticeElementCell];
            }];
            if (buyNotice.notice.count>0) {
                WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell_last = [self cellWithID:BuyNoticeEmptyCellID];
                if (buyNoticeEmptyCell_last) [section02 addObject:buyNoticeEmptyCell_last];
            }
            if(section02.count>0) [sections addObject:section02];
        }
    }];
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (base.productTime) {
        WolesaleProductDetailTimeCell *timeCell = [self cellWithID:TimeCellID];
        if (timeCell) [section03 addObject:timeCell];
    }
    switch (base.placeType) {
        case PlaceTypeStore:
        {
            if (base.stores.count>0) {
                WolesaleProductDetailV2PlaceCell *V2PlaceCell = [self cellWithID:V2PlaceCellID];
                if (V2PlaceCell) [section03 addObject:V2PlaceCell];
            }
            if (base.stores.count>1) {
                WolesaleProductDetailV2PlaceCountCell *V2PlaceCountCell = [self cellWithID:V2PlaceCountCellID];
                if (V2PlaceCountCell) [section03 addObject:V2PlaceCountCell];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (base.place.count>0) {
                WolesaleProductDetailV2PlaceCell *V2PlaceCell = [self cellWithID:V2PlaceCellID];
                if (V2PlaceCell) [section03 addObject:V2PlaceCell];
            }
            if (base.place.count>1) {
                WolesaleProductDetailV2PlaceCountCell *V2PlaceCountCell = [self cellWithID:V2PlaceCountCellID];
                if (V2PlaceCountCell) [section03 addObject:V2PlaceCountCell];
            }
        }
            break;
        default:
            break;
    }
    if(section03.count>0) [sections addObject:section03];
    
    //video
    VideoPlayVideoRes *productVideoRes = base.productVideoRes;
    if (productVideoRes.productVideos.count>0) {
        NSMutableArray *videoSection = [NSMutableArray new];
        if ([productVideoRes.productVideoTitle isNotNull]) {
            WolesaleProductDetailVideoTipCell *videoTipCell = [self cellWithID:VideoTipCellID];
            videoTipCell.title = productVideoRes.productVideoTitle;
            if (videoTipCell) [videoSection addObject:videoTipCell];
        }
        [productVideoRes.productVideos enumerateObjectsUsingBlock:^(VideoPlayVideo *obj, NSUInteger idx, BOOL *stop) {
            WolesaleProductDetailVideoCell *videoCell = [self cellWithID:VideoCellID];
            videoCell.tag = idx;
            if (videoCell) [videoSection addObject:videoCell];
        }];
        if (videoSection.count>0) [sections addObject:videoSection];
    }
    
    NSMutableArray *section05 = [NSMutableArray array];
    if ([base.detailUrl isNotNull]) {
        WolesaleProductDetailV2WebTitleCell *V2WebTitleCell = [self cellWithID:V2WebTitleCellID];
        if (V2WebTitleCell) [section05 addObject:V2WebTitleCell];
        WolesaleProductDetailWebCell *webCell = [self cellWithID:WebCellID];
        if (webCell) [section05 addObject:webCell];
    }
    if(section05.count>0) [sections addObject:section05];
    
    
    NSMutableArray *section04 = [NSMutableArray array];
    if (base.otherProducts.count>0 && [base.otherPackageTitle isNotNull]) {
        WolesaleProductDetailTitleCell *titleCell_otherProduct = [self cellWithID:TitleCellID];
        titleCell_otherProduct.title = base.otherPackageTitle;
        if (titleCell_otherProduct) [section04 addObject:titleCell_otherProduct];
    }
    [base.otherProducts enumerateObjectsUsingBlock:^(WholesaleProductDetailOtherProduct *otherProduct, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailOtherPorductCell *otherPorductCell = [self cellWithID:OtherPorductCellID];
        otherPorductCell.otherProduct = otherProduct;
        if (otherPorductCell) [section04 addObject:otherPorductCell];
    }];

    if(section04.count>0) [sections addObject:section04];
    
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
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<WolesaleProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WolesaleProductDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark WolesaleProductDetailBaseCellDelegate

- (void)wolesaleProductDetailBaseCell:(WolesaleProductDetailBaseCell *)cell actionType:(WolesaleProductDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailView:actionType:value:)]) {
        [self.delegate wolesaleProductDetailView:self actionType:(WolesaleProductDetailViewActionType)type value:value];
    }
    if (type == WolesaleProductDetailBaseCellActionTypeWebLoadFinish) {
        [self.tableView reloadData];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WolesaleProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WolesaleProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWolesaleProductDetailToolBarH, SCREEN_WIDTH, kWolesaleProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark WolesaleProductDetailToolBarDelegate

- (void)wolesaleProductDetailToolBar:(WolesaleProductDetailToolBar *)toolBar actionType:(WolesaleProductDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailView:actionType:value:)]) {
        [self.delegate wolesaleProductDetailView:self actionType:(WolesaleProductDetailViewActionType)type value:value];
    }
    if (type == WolesaleProductDetailViewActionTypeJoin && self.data.fightGroupBase.teams.count>0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end
