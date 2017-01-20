//
//  CookieManager.h
//  KidsTC
//
//  Created by zhanping on 4/8/16.
//  Copyright © 2016 ping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

extern NSString *const CookieDomain;
extern NSString *const CookieKey_uid;
extern NSString *const CookieKey_skey;
extern NSString *const CookieKey_appversion;
extern NSString *const CookieKey_deviceid;
extern NSString *const CookieKey_appsource;
extern NSString *const CookieKey_app;
extern NSString *const CookieKey_mapaddr;
extern NSString *const CookieKeyUserRole;
extern NSString *const CookieKeyGuid;

@interface CookieManager : NSObject
singleH(CookieManager)
- (void)setCookies;
- (void)setCookieWithName:(NSString *)name andValue:(NSString *)value;
- (void)deleteCookieWithName:(NSString *)name;
- (void)checkUid;
@end
