//
//  KTCShareService.h
//  KidsTC
//
//  Created by Altair on 12/7/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    KTCShareServiceChannelWechatSession = 1,
    KTCShareServiceChannelWechatTimeLine,
    KTCShareServiceChannelWeibo,
    KTCShareServiceChannelQQ,
    KTCShareServiceChannelQZone
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
}KTCShareServiceType;

@interface KTCShareService : NSObject

+ (instancetype)service;

- (void)sendShareSucceedFeedbackToServerWithIdentifier:(NSString *)identifier
                                               channel:(KTCShareServiceChannel)channel
                                                  type:(KTCShareServiceType)type
                                                 title:(NSString *)title;

@end
