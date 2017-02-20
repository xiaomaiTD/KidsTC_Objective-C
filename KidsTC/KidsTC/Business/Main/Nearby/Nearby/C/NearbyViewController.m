//
//  NearbyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyViewController.h"
#import "NavigationController.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "KTCFavouriteManager.h"
#import "NSString+Category.h"
#import "GuideManager.h"
#import "BuryPointManager.h"

#import "NearbyModel.h"
#import "NearbyRecommendModel.h"
#import "NearbyView.h"
#import "NearbyTitleView.h"
#import "NearbyCalendarViewController.h"
#import "MapLocateViewController.h"
#import "SearchViewController.h"
#import "NurseryViewController.h"
#import "WebViewController.h"


@interface NearbyViewController ()<NearbyTitleViewDelegate,NearbyViewDelegate>
@property (weak, nonatomic) NearbyView *nearbyView;
@property (nonatomic, strong) NSArray<NearbyData *> *datas;
@property (nonatomic, strong) NSString *categoryValue;
@property (nonatomic,assign) NSInteger recommendPage;
@property (nonatomic,strong) NSArray<NearbyItem *> *recommendDatas;
@property (nonatomic,assign) BOOL changeLocalAddress;
@end

@implementation NearbyViewController

- (NSArray<NearbyData *> *)datas {
    if (!_datas) {
        NearbyData *data00 = [NearbyData new];
        NearbyData *data01 = [NearbyData new];
        NearbyData *data02 = [NearbyData new];
        data00.stValue = @"1";//人气
        data01.stValue = @"4";//价格
        data02.stValue = @"2";//促销
        _datas = [NSArray arrayWithObjects:data00,data01,data02,nil];
    }
    return _datas;
}

- (NSString *)categoryValue {
    if (!_categoryValue) {
        _categoryValue = @"";
    }
    return _categoryValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageId = 11200;
    
    NearbyView *nearbyView = [[NearbyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    nearbyView.delegate = self;
    nearbyView.datas = self.datas;
    [self.view addSubview:nearbyView];
    self.nearbyView = nearbyView;
    
    NearbyTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:@"NearbyTitleView" owner:self options:nil].firstObject;
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    
    [NotificationCenter addObserver:self selector:@selector(userLocation) name:kUserLocationHasChangedNotification object:nil];
}

#pragma mark - NearbyTitleViewDelegate

- (void)nearbyTitleView:(NearbyTitleView *)view actionType:(NearbyTitleViewActionType)type value:(id)v {
    switch (type) {
        case NearbyTitleViewActionTypeAddress:
        {
            MapLocateViewController *controller = [[MapLocateViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            [BuryPointManager trackEvent:@"event_skip_nearby_location" actionId:21700 params:nil];
            self.changeLocalAddress = YES;
        }
            break;
            
        case NearbyTitleViewActionTypeSearch:
        {
            SearchViewController *controller = [[SearchViewController alloc]init];
            NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:NO completion:nil];
            [BuryPointManager trackEvent:@"event_skip_nearby_search" actionId:21701 params:nil];
        }
            break;
    }
}

#pragma mark - NearbyViewDelegate

- (void)nearbyView:(NearbyView *)view nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyViewActionType)type value:(id)value {
    switch (type) {
        case NearbyViewActionTypeNursery:
        case NearbyViewActionTypeExhibition:
        {
            [self nursery:type data:value];
        }
            break;
        case NearbyViewActionTypeCalendar:
        {
            [self calendar:value];
        }
            break;
        case NearbyViewActionTypeLoadData:
        {
            [self loadDataWithCell:cell refresh:value];
        }
            break;
        case NearbyViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case NearbyViewActionTypeLike:
        {
            [self like:value];
        }
            break;
        case NearbyViewActionTypeDidSelectCategory:
        {
            [self didSelectCategory:value];
        }
            break;
        case NearbyViewActionTypeLoadRecommend:
        {
            [self loadRecommendWithCell:cell refresh:value];
        }
            break;
        default:
        {
            [self nursery:type data:value];
        }
            break;
    }
}

#pragma mark ============ 育儿室 ============

- (void)nursery:(NearbyViewActionType)type data:(NearbyPlaceInfoData *)data{
    if (![data isKindOfClass:[NearbyPlaceInfoData class]]) {
        return;
    }
    NurseryViewController *controller = [[NurseryViewController alloc] init];
    controller.type = (NurseryType)type;
    controller.navigationItem.title = data.title;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ============跳转日历============

- (void)calendar:(id)value {
    NearbyCalendarViewController *controller = [[NearbyCalendarViewController alloc] initWithNibName:@"NearbyCalendarViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    [BuryPointManager trackEvent:@"event_skip_nearby_calendar" actionId:21702 params:nil];
}

#pragma mark ============加载数据============

- (void)loadDataWithCell:(NearbyCollectionViewCell *)cell
                 refresh:(id)value
{
    if (![value respondsToSelector:@selector(boolValue)]) {
        [cell dealWithUI:0];
        return;
    }
    BOOL refresh = [value boolValue];
    
    NSInteger index = cell.index;
    if (index>=self.datas.count) [cell dealWithUI:0];
    NearbyData *data = self.datas[index];
    data.currentPage = refresh?1:(data.currentPage+1);
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(data.currentPage) forKey:@"page"];
    [param setObject:@(TCPAGECOUNT) forKey:@"pageSize"];
    NSString *c = self.categoryValue;
    if ([c isNotNull]) {
        [param setObject:c forKey:kSearchKey_category];
    }
    NSString *st = data.stValue;
    if ([st isNotNull]) {
        [param setObject:st forKey:kSearchKey_sort];
    }
    NSString *pt = [User shareUser].role.roleIdentifierString;
    if ([pt isNotNull]) {
        [param setObject:pt forKey:kSearchKey_populationType];
    }
    
    [Request startWithName:@"SEARCH_NEARBY_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NearbyData *loadData = [NearbyModel modelWithDictionary:dic].data;
        NSArray<NearbyItem *> *items = loadData.data;
        NearbyPlaceInfo *placeInfo = loadData.placeInfo;
        if (refresh) {
            data.data = items;
            data.placeInfo = placeInfo;
            if ((index == 0) && placeInfo.isShow && (placeInfo.leftData || placeInfo.rightData) && data.data.count>0) {
                [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeNearby resultBlock:nil];
            }
        }else{
            NSMutableArray *datas = [NSMutableArray arrayWithArray:data.data];
            [datas addObjectsFromArray:items];
            data.data = datas;
        }
        [cell dealWithUI:loadData.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [cell dealWithUI:0];
    }];
}

- (void)loadRecommendWithCell:(NearbyCollectionViewCell *)cell refresh:(id)value {
    
    if (![value respondsToSelector:@selector(boolValue)]) {
        [cell dealWithUI:0];
        return;
    }
    BOOL refresh = [value boolValue];
    
    NSInteger index = cell.index;
    if (index>=self.datas.count) [cell dealWithUI:0];
    NearbyData *data = self.datas[index];
    
    self.recommendPage = refresh?1:++self.recommendPage;
    NSDictionary *param = @{@"page":@(self.recommendPage),
                            @"pageSize":@(TCPAGECOUNT)};
    [Request startWithName:@"NEAR_BY_RECOMMEND_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<NearbyItem *> *recommendData = [NearbyRecommendModel modelWithDictionary:dic].data;
        if (refresh) {
            self.recommendDatas = [NSArray arrayWithArray:recommendData];
        }else{
            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.recommendDatas];
            [ary addObjectsFromArray:recommendData];
            self.recommendDatas = [NSArray arrayWithArray:ary];
        }
        data.data = self.recommendDatas;
        
        [cell dealWithUI:recommendData.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [cell dealWithUI:0];
    }];
}

#pragma mark ============添加关注============

- (void)like:(id)value {
    NearbyItem *item = value;
    NSString *serveId = item.serveId;
    KTCFavouriteType type = KTCFavouriteTypeService;
    ProductDetailType productSearchType = item.productSearchType;
    switch (productSearchType) {
        case ProductDetailTypeNormal:
        {
            type = KTCFavouriteTypeService;
        }
            break;
        case ProductDetailTypeTicket:
        {
            type = KTCFavouriteTypeTicketService;
        }
            break;
        case ProductDetailTypeFree:
        {
            type = KTCFavouriteTypeFreeService;
        }
            break;
        default:
        {
            type = KTCFavouriteTypeService;
        }
            break;
    }
    if (item.isInterest) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:serveId type:type succeed:nil failure:nil];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:serveId type:type succeed:nil failure:nil];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = serveId;
    if ([pid isNotNull]) {
        [params setValue:pid forKey:@"pid"];
    }
    NSString *cid = item.channelId;
    if ([cid isNotNull]) {
        [params setValue:cid forKey:@"cid"];
    }
    [BuryPointManager trackEvent:@"event_click_nearby_favor" actionId:21703 params:params];
}

#pragma mark ============选择分类============

- (void)didSelectCategory:(id)value {
    if (![value isKindOfClass:[NearbyCategoryToolBarItem class]]) return;
    NearbyCategoryToolBarItem *item = value;
    self.categoryValue = [NSString stringWithFormat:@"%@",item.value];
    self.datas = nil;
    self.nearbyView.datas = self.datas;
}


#pragma mark - userLocation

- (void)userLocation {
    if (!self.changeLocalAddress) return;
    self.datas = nil;
    self.nearbyView.datas = self.datas;
    self.changeLocalAddress = NO;
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}

@end
