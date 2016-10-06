//
//  KTCPaymentService.h
//  KidsTC
//
//  Created by Altair on 11/21/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTCPaymentInfo.h"
#import "PayModel.h"

@interface KTCPaymentService : NSObject

+ (instancetype)sharedService;

+ (void)startPay:(PayInfo *)info succeed:(void (^)())succeed failure:(void (^)(NSError *))failure;

@end