//
//  ActivityViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 10/12/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ActivityViewModel.h"

#import "GHeader.h"

#define PageSize (10)

@interface ActivityViewModel () <ActivityViewDataSource>

@property (nonatomic, weak) ActivityView *view;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger currentPageIndex;


- (void)loadActivitiesSucceedWithData:(NSDictionary *)data;

- (void)loadActivitiesFailedWithError:(NSError *)error;

- (void)loadMoreActivitiesSucceedWithData:(NSDictionary *)data;

- (void)loadMoreActivitiesFailedWithError:(NSError *)error;

- (void)reloadActivityViewWithData:(NSDictionary *)data;

@end

@implementation ActivityViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (ActivityView *)view;
        self.view.dataSource = self;
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark

- (NSArray *)listItemModelsOfActivityView:(ActivityView *)view {
    return [self resultArray];
}

#pragma mark Private methods


- (void)loadActivitiesSucceedWithData:(NSDictionary *)data {
    [self.dataArray removeAllObjects];
    [self reloadActivityViewWithData:data];
}

- (void)loadActivitiesFailedWithError:(NSError *)error {
    [self.dataArray removeAllObjects];
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -1003:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self reloadActivityViewWithData:nil];
    [self.view endRefresh];
}

- (void)loadMoreActivitiesSucceedWithData:(NSDictionary *)data {
    self.currentPageIndex += 1;
    [self reloadActivityViewWithData:data];
    [self.view endLoadMore];
}

- (void)loadMoreActivitiesFailedWithError:(NSError *)error {
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -1003:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self reloadActivityViewWithData:nil];
    [self.view endLoadMore];
}

- (void)reloadActivityViewWithData:(NSDictionary *)data {
    NSArray *dataArray = [data objectForKey:@"data"];
    if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
        [self.view hideLoadMoreFooter:NO];
        for (NSDictionary *singleItem in dataArray) {
            ActivityListItemModel *model = [[ActivityListItemModel alloc] initWithRawData:singleItem];
            if (model) {
                [self.dataArray addObject:model];
            }
        }
        if ([dataArray count] < PageSize) {
            [self.view noMoreData:YES];
        } else {
            [self.view noMoreData:NO];
        }
    } else {
        [self.view noMoreData:YES];
        [self.view hideLoadMoreFooter:YES];
    }
    [self.view reloadData];
    [self.view endRefresh];
    [self.view endLoadMore];
}

#pragma mark Public methods

- (void)getCategoryDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    
    [Request startWithName:@"PRODUCT_ACTIVITY_FILTER_GET" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}

- (NSArray *)resultArray {
    return [NSArray arrayWithArray:self.dataArray];
}

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    
    self.currentPageIndex = 1;
    
    NSString *areaId = @"0";
    if (self.currentAreaItem) {
        areaId = self.currentAreaItem.identifier;
    }
    NSString *categoryId = @"0";
    if (self.currentCategoryItem) {
        categoryId = self.currentCategoryItem.identifier;
    }
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           categoryId, @"categoryId",
                           [NSNumber numberWithInteger:self.currentPageIndex], @"page",
                           [NSNumber numberWithInteger:PageSize], @"pageCount",
                           areaId, @"districtId", nil];
    
    [Request startWithName:@"PRODUCT_ACTIVITY_GET_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadActivitiesSucceedWithData:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadActivitiesFailedWithError:error];
        if (failure) failure(error);
    }];
}

- (void)getMoreDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    
    NSUInteger pageIndex = self.currentPageIndex + 1;
    
    NSString *areaId = @"0";
    if (self.currentAreaItem) {
        areaId = self.currentAreaItem.identifier;
    }
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"", @"category",
                           [NSNumber numberWithInteger:pageIndex], @"page",
                           [NSNumber numberWithInteger:PageSize], @"pageCount",
                           areaId, @"distinct", nil];
    
    [Request startWithName:@"PRODUCT_ACTIVITY_GET_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadMoreActivitiesSucceedWithData:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadMoreActivitiesFailedWithError:error];
        if (failure) failure(error);
    }];
}


#pragma mark Super methods

- (void)stopUpdateData {
    [self.view endRefresh];
    [self.view endLoadMore];
}

@end
