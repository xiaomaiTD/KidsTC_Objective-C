//
//  KTCBrowseHistoryManager.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCBrowseHistoryManager.h"
#import "GHeader.h"

#define PageSize (10)

static KTCBrowseHistoryManager *_sharedInstance = nil;

@interface KTCBrowseHistoryManager ()

@property (nonatomic, strong) NSMutableArray *serviceResultArray;

@property (nonatomic, strong) NSMutableArray *storeResultArray;

@property (nonatomic, assign) NSUInteger pageIndex;

@end

@implementation KTCBrowseHistoryManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.serviceResultArray = [[NSMutableArray alloc] init];
        self.storeResultArray = [[NSMutableArray alloc] init];
        self.pageIndex = 1;
    }
    return self;
}

+ (instancetype)sharedManager {
    static dispatch_once_t token = 0;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[KTCBrowseHistoryManager alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark Private methods

- (void)clearDataForType:(KTCBrowseHistoryType)type {
    switch (type) {
        case KTCBrowseHistoryTypeService:
        {
            [self.serviceResultArray removeAllObjects];
        }
            break;
        case KTCBrowseHistoryTypeStore:
        {
            [self.storeResultArray removeAllObjects];
        }
        default:
            break;
    }
}

- (void)loadHistorySucceedWithData:(NSDictionary *)data type:(KTCBrowseHistoryType)type {
    [self parseLoadResult:data type:type];
}

- (void)loadHistoryFailedWithError:(NSError *)error type:(KTCBrowseHistoryType)type {
    [self parseLoadResult:nil type:type];
}

- (void)loadMoreHistorySucceedWithData:(NSDictionary *)data type:(KTCBrowseHistoryType)type {
    self.pageIndex ++;
    [self parseLoadResult:data type:type];
}

- (void)loadMoreHistoryFailedWithError:(NSError *)error type:(KTCBrowseHistoryType)type {
    [self parseLoadResult:nil type:type];
}

- (void)parseLoadResult:(NSDictionary *)data type:(KTCBrowseHistoryType)type {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSArray *dataArray = [data objectForKey:@"data"];
    if ([dataArray isKindOfClass:[NSArray class]]) {
        switch (type) {
            case KTCBrowseHistoryTypeService:
            {
                for (NSDictionary *singleElem in dataArray) {
                    BrowseHistoryServiceListItemModel *model = [[BrowseHistoryServiceListItemModel alloc] initWithRawData:singleElem];
                    if (model) {
                        [self.serviceResultArray addObject:model];
                    }
                }
                return;
            }
                break;
            case KTCBrowseHistoryTypeStore:
            {
                for (NSDictionary *singleElem in dataArray) {
                    BrowseHistoryStoreListItemModel *model = [[BrowseHistoryStoreListItemModel alloc] initWithRawData:singleElem];
                    if (model) {
                        [self.storeResultArray addObject:model];
                    }
                }
                return;
            }
            default:
                break;
        }
    }
}

#pragma mark Public methods

- (void)getUserBrowseHistoryWithType:(KTCBrowseHistoryType)type needMore:(BOOL)need succeed:(void (^)(NSArray *))succeed failure:(void (^)(NSError *))failure {
    NSUInteger index = 0;
    if (need) {
        index = self.pageIndex + 1;
    } else {
        [self clearDataForType:type];
        index = self.pageIndex = 1;
    }
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:type], @"type",
                           [NSNumber numberWithInteger:index], @"page",
                           [NSNumber numberWithInteger:PageSize], @"pagecount", nil];
    
    [Request startWithName:@"GET_BROWSE_RECORD" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if (need) {
            [self loadMoreHistorySucceedWithData:dic type:type];
        } else {
            [self loadHistorySucceedWithData:dic type:type];
        }
        if (succeed) {
            succeed([self resultForType:type]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (need) {
            [self loadMoreHistoryFailedWithError:error type:type];
        } else {
            [self loadHistoryFailedWithError:error type:type];
        }
        if (failure) {
            failure(error);
        }
    }];
}

- (NSArray *)resultForType:(KTCBrowseHistoryType)type {
    switch (type) {
        case KTCBrowseHistoryTypeService:
        {
            return [NSArray arrayWithArray:self.serviceResultArray];
        }
            break;
        case KTCBrowseHistoryTypeStore:
        {
            return [NSArray arrayWithArray:self.storeResultArray];
        }
        default:
            break;
    }
    return nil;
}

@end
