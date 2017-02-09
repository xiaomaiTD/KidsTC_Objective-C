//
//  KTCFavouriteManager.h
//  KidsTC
//
//  Created by 钱烨 on 8/21/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    KTCFavouriteTypeService,//普通服务
    KTCFavouriteTypeStore,//门店
    KTCFavouriteTypeStrategy,//攻略
    KTCFavouriteTypeNews,//资讯
    KTCFavouriteTypeTicketService,//票务
    KTCFavouriteTypeFreeService,//免费
    KTCFavouriteTypeRadish//萝卜
}KTCFavouriteType;

@interface KTCFavouriteManager : NSObject

+ (instancetype)sharedManager;

- (void)addFavouriteWithIdentifier:(NSString *)identifier
                              type:(KTCFavouriteType)type
                           succeed:(void(^)(NSDictionary *data))succeed
                           failure:(void(^)(NSError *error))failure;

- (void)deleteFavouriteWithIdentifier:(NSString *)identifier
                                 type:(KTCFavouriteType)type
                              succeed:(void(^)(NSDictionary *data))succeed
                              failure:(void(^)(NSError *error))failure;

- (void)loadFavouriteWithType:(KTCFavouriteType)type
                         page:(NSUInteger)page
                     pageSize:(NSUInteger)pageSize
                      succeed:(void(^)(NSDictionary *data))succeed
                      failure:(void(^)(NSError *error))failure;
@end
