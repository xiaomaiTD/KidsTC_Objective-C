//
//  KTCShareService.h
//  KidsTC
//
//  Created by Altair on 12/7/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    KTCShareServiceChannelWechatSession = 1,//微信好友
    KTCShareServiceChannelWechatTimeLine = 2,//微信朋友圈
    KTCShareServiceChannelWeibo = 3,//微博
    KTCShareServiceChannelQQ = 4,//QQ
    KTCShareServiceChannelQZone = 5//QQ空间
}KTCShareServiceChannel;

typedef enum {
    KTCShareServiceTypeUnknow = 0,
    KTCShareServiceTypeStore = 1,
    KTCShareServiceTypeService = 2,
    KTCShareServiceTypeNews = 3,
    KTCShareServiceTypeStrategy = 4,
    KTCShareServiceTypeActivity = 5,
    KTCShareServiceTypeTicketService = 6,
    KTCShareServiceTypeFree = 7,
    KTCShareServiceTypeWholesale = 8,
    KTCShareServiceTypeSeckill = 9,
    KTCShareServiceTypeRadish = 10,
    KTCShareServiceTypeEvent = 11,
}KTCShareServiceType;

@interface KTCShareService : NSObject

+ (instancetype)service;

- (void)sendShareSucceedFeedbackToServerWithIdentifier:(NSString *)identifier
                                               channel:(KTCShareServiceChannel)channel
                                                  type:(KTCShareServiceType)type
                                                 title:(NSString *)title;

@end
