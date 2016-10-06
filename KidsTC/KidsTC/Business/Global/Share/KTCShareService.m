//
//  KTCShareService.m
//  KidsTC
//
//  Created by Altair on 12/7/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCShareService.h"
#import "GHeader.h"
static KTCShareService *_sharedInstance = nil;

@interface KTCShareService ()

@end

@implementation KTCShareService

+ (instancetype)service {
    static dispatch_once_t token = 0;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[KTCShareService alloc] init];
    });
    
    return _sharedInstance;
}

- (void)sendShareSucceedFeedbackToServerWithIdentifier:(NSString *)identifier
                                               channel:(KTCShareServiceChannel)channel
                                                  type:(KTCShareServiceType)type
                                                 title:(NSString *)title {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           identifier, @"id",
                           [NSNumber numberWithInteger:channel], @"channel",
                           [NSNumber numberWithInteger:type], @"type",
                           title, @"name", nil];
    [Request startWithName:@"SHARE_ADD_RECORD" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"Send share feedback succeed");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TCLog(@"Send share feedback failed");
    }];
}

@end
