//
//  NearbyCalendarViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarViewController.h"
#import "Colours.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "KTCFavouriteManager.h"
#import "NearbyCalendarToolBarCategoryItem.h"
#import "NSString+ZP.h"
#import "ZPDateFormate.h"
#import "SegueMaster.h"

#import "NearbyCalendarView.h"

@interface NearbyCalendarViewController ()<NearbyCalendarViewDelegate>
@property (strong, nonatomic) IBOutlet NearbyCalendarView *filterView;
@property (nonatomic, strong) NSString *categoryValue;
@property (nonatomic, strong) NSString *time;
@end

@implementation NearbyCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日历";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    self.time = [NSString zp_stringWithDate:[NSDate date] Format:DF_yMd];
    self.filterView.delegate = self;
}

#pragma mark - NearbyCalendarViewDelegate

- (void)nearbyCalendarView:(NearbyCalendarView *)view actionType:(NearbyCalendarViewActionType)type value:(id)value {
    
    switch (type) {
        case NearbyCalendarViewActionTypeDidSelectDate:
        {
            [self didSelectDate:value];
        }
            break;
        case NearbyCalendarViewActionTypeDidSelectCategory:
        {
            [self didSelectCategory:value];
        }
            break;
        case NearbyCalendarViewActionTypeLike:
        {
            [self like:value];
        }
            break;
        case NearbyCalendarViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case NearbyCalendarViewActionTypeLoadData:
        {
            [self loadDataWithView:view refresh:value];
        }
            break;
    }
}

#pragma mark ============选择分类============

- (void)didSelectDate:(id)value {
    if (![value isKindOfClass:[NSDate class]]) return;
    NSDate *date = value;
    self.time = [NSString zp_stringWithDate:date Format:DF_yMd];
    self.filterView.data = nil;
}


#pragma mark ============选择分类============

- (void)didSelectCategory:(id)value {
    if (![value isKindOfClass:[NearbyCalendarToolBarCategoryItem class]]) return;
    NearbyCalendarToolBarCategoryItem *item = value;
    self.categoryValue = [NSString stringWithFormat:@"%@",item.value];
    self.filterView.data = nil;
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
}

#pragma mark ============加载数据============

- (void)loadDataWithView:(NearbyCalendarView *)view
                 refresh:(id)value
{
    if (![value respondsToSelector:@selector(boolValue)]) {
        [view dealWithUI:0];
        return;
    }
    BOOL refresh = [value boolValue];
    
    NearbyData *data = view.data;
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
    NSString *time = self.time;
    if ([time isNotNull]) {
        [param setObject:time forKey:@"time"];
    }
    
    [Request startWithName:@"SEARCH_NEARBY_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NearbyData *loadData = [NearbyModel modelWithDictionary:dic].data;
        NSArray<NearbyItem *> *items = loadData.data;
        NearbyPlaceInfo *placeInfo = loadData.placeInfo;
        if (refresh) {
            data.data = items;
            data.placeInfo = placeInfo;
        }else{
            NSMutableArray *datas = [NSMutableArray arrayWithArray:data.data];
            [datas addObjectsFromArray:items];
            data.data = datas;
        }
        [view dealWithUI:loadData.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [view dealWithUI:0];
    }];
}

@end
