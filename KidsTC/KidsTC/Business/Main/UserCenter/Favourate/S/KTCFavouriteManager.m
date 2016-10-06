//
//  KTCFavouriteManager.m
//  KidsTC
//
//  Created by 钱烨 on 8/21/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "KTCFavouriteManager.h"
#import "GHeader.h"
#import "KTCMapService.h"

static KTCFavouriteManager *_sharedInstance = nil;

@interface KTCFavouriteManager ()
@end

@implementation KTCFavouriteManager

+ (instancetype)sharedManager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedInstance = [[KTCFavouriteManager alloc] init];
    });
    return _sharedInstance;
}

- (void)addFavouriteWithIdentifier:(NSString *)identifier
                              type:(KTCFavouriteType)type
                           succeed:(void (^)(NSDictionary *))succeed
                           failure:(void (^)(NSError *))failure {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           identifier, @"number",
                           [NSNumber numberWithInteger:type], @"type", nil];
    [Request startWithName:@"COLLECT_ADD" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}

- (void)deleteFavouriteWithIdentifier:(NSString *)identifier
                                 type:(KTCFavouriteType)type
                              succeed:(void (^)(NSDictionary *))succeed
                              failure:(void (^)(NSError *))failure {
    
    
    switch (type) {
        case KTCFavouriteTypeService:
        case KTCFavouriteTypeStore:
        case KTCFavouriteTypeStrategy:
        {
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   identifier, @"number",
                                   [NSNumber numberWithInteger:type], @"type", nil];
            [Request startWithName:@"COLLECT_DELETE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                if (succeed) succeed(dic);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) failure(error);
            }];
        }
            break;
        case KTCFavouriteTypeNews:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)loadFavouriteWithType:(KTCFavouriteType)type
                         page:(NSUInteger)page
                     pageSize:(NSUInteger)pageSize
                      succeed:(void (^)(NSDictionary *))succeed
                      failure:(void (^)(NSError *))failure {
    switch (type) {
        case KTCFavouriteTypeService:
        case KTCFavouriteTypeStore:
        case KTCFavouriteTypeStrategy:
        {
            NSMutableDictionary *tempParam = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInteger:type], @"type",
                                              [NSNumber numberWithInteger:page], @"page",
                                              [NSNumber numberWithInteger:pageSize], @"pagecount", nil];
            if (type == KTCFavouriteTypeStore || type == KTCFavouriteTypeService) {
                [tempParam setObject:[KTCMapService shareKTCMapService].currentLocationString forKey:@"mapaddr"];
            }
            [Request startWithName:@"COLLECT_QUERY" param:tempParam progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                if (succeed) succeed(dic);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) failure(error);
            }];
        }
            break;
        case KTCFavouriteTypeNews:
        {
            NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%lu",page],@"pageCount":[NSString stringWithFormat:@"%lu",pageSize]};
            [Request startWithName:@"GET_USER_COLLECT_ARTICLE" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                if (succeed) succeed(dic);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) failure(error);
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
