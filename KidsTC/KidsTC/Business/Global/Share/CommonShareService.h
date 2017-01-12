//
//  CommonShareService.h
//  KidsTC
//
//  Created by Altair on 11/20/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    CommonShareTypeWechatSession = 0,//微信好友
    CommonShareTypeWechatTimeLine = 1,//微信盆友圈
    CommonShareTypeWeibo = 2,//微博
    CommonShareTypeQQ = 3,//QQ
    CommonShareTypeQZone = 4//QQ空间
}CommonShareType;

extern NSString *const kCommonShareTypeWechatSessionKey;
extern NSString *const kCommonShareTypeWechatTimeLineKey;
extern NSString *const kCommonShareTypeWeiboKey;
extern NSString *const kCommonShareTypeQQKey;
extern NSString *const kCommonShareTypeQZoneKey;

@class CommonShareObject;

@interface CommonShareService : NSObject

+ (instancetype)sharedService;

+ (NSArray<NSNumber *> *)availableShareTypes;

+ (NSDictionary *)shareTypeAvailablities;

- (BOOL)startThirdPartyShareWithType:(CommonShareType)type
                              object:(CommonShareObject *)object
                             succeed:(void(^)())succeed
                             failure:(void(^)(NSError *error))failure;

- (BOOL)startThirdPartyShareImageWithType:(CommonShareType)type
                                   object:(CommonShareObject *)object
                                  succeed:(void(^)())succeed
                                  failure:(void(^)(NSError *error))failure;
@end
