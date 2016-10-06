//
//  ParentingStrategyViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/24/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ParentingStrategyViewModel.h"
#import "GHeader.h"

#define PageSize (10)

@interface ParentingStrategyViewModel () <ParentingStrategyViewDataSource>

@property (nonatomic, weak) ParentingStrategyView *view;

@property (nonatomic, strong) NSMutableArray *itemModelsArray;

@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation ParentingStrategyViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (ParentingStrategyView *)view;
        self.view.dataSource = self;
        self.itemModelsArray = [[NSMutableArray alloc] init];
        self.currentSortType = ParentingStrategySortTypeTime;
    }
    return self;
}

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    self.currentPage = 1;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:self.currentPage], @"page",
                           [NSNumber numberWithInteger:PageSize], @"pageCount",
                           [NSNumber numberWithInteger:self.currentSortType], @"orderByType", nil];
    [Request startWithName:@"STRATEGY_SEARCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadStrategyListSucceed:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadStrategyListFailed:error];
        if (failure) failure(error);
    }];
}


- (void)stopUpdateData {
    [self.view endRefresh];
    [self.view endLoadMore];
}


#pragma mark StrategyListViewDataSource

- (NSArray *)listItemModelsOfParentingStrategyView:(ParentingStrategyView *)strategyView {
    return [self resutlStrategies];
}

#pragma mark Private methods

- (void)loadStrategyListSucceed:(NSDictionary *)data {
    [self.itemModelsArray removeAllObjects];
    [self reloadListViewWithData:data];
}

- (void)loadStrategyListFailed:(NSError *)error {
    [self.itemModelsArray removeAllObjects];
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -2001:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self reloadListViewWithData:nil];
    [self.view endRefresh];
}

- (void)loadMoreStrategyListSucceed:(NSDictionary *)data {
    self.currentPage ++;
    [self reloadListViewWithData:data];
}

- (void)loadMoreStrategyListFailed:(NSError *)error {
    switch (error.code) {
        case -999:
        {
            //cancel
            return;
        }
            break;
        case -2001:
        {
            //没有数据
            [self.view noMoreData:YES];
        }
            break;
        default:
            break;
    }
    [self.view endLoadMore];
}

- (void)reloadListViewWithData:(NSDictionary *)data {
    if ([data count] > 0) {
        NSArray *dataArray = [data objectForKey:@"data"];
        if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
            [self.view hideLoadMoreFooter:NO];
            for (NSDictionary *singleStrategy in dataArray) {
                ParentingStrategyListItemModel *model = [[ParentingStrategyListItemModel alloc] initWithRawData:singleStrategy];
                if (model) {
                    [self.itemModelsArray addObject:model];
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
    } else {
        [self.view hideLoadMoreFooter:YES];
    }
    [self.view reloadData];
    [self stopUpdateData];
}

#pragma mark Public methods

- (NSArray *)resutlStrategies {
    return [NSArray arrayWithArray:self.itemModelsArray];
}

- (void)getMoreStrategies {
    
    NSUInteger nextPage = self.currentPage + 1;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:self.currentSortType], @"orderByType",
                           [NSNumber numberWithInteger:nextPage], @"page",
                           [NSNumber numberWithInteger:PageSize], @"pageCount", nil];
    [Request startWithName:@"STRATEGY_SEARCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadMoreStrategyListSucceed:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadMoreStrategyListFailed:error];
    }];
}

@end
