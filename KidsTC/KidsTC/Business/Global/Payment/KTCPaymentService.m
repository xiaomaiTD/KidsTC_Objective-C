//
//  KTCPaymentService.m
//  KidsTC
//
//  Created by Altair on 11/21/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCPaymentService.h"
#import "AlipayManager.h"
#import "WeChatManager.h"
#import "GHeader.h"
static KTCPaymentService *_sharedInstance = nil;

@interface KTCPaymentService ()

@end

@implementation KTCPaymentService

+ (instancetype)sharedService {
    static dispatch_once_t token = 0;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[KTCPaymentService alloc] init];
    });
    
    return _sharedInstance;
}

+ (void)startPay:(PayInfo *)info succeed:(void (^)())succeed failure:(void (^)(NSError *))failure {
    switch (info.payType) {
        case PayTypeNone:
        {
            succeed();
        }
            break;
        case PayTypeAli:
        {
            [[AlipayManager sharedManager] startPaymentWithUrlString:info.payUrl succeed:succeed failure:failure];
        }
            break;
        case PayTypeWeChat:
        {
            [[WeChatManager sharedManager] sendPay:info succeed:succeed failure:failure];
        }
            break;
        default:
            break;
    }
}

@end