//
//  CookieManager.m
//  KidsTC
//
//  Created by zhanping on 4/8/16.
//  Copyright © 2016 ping. All rights reserved.
//
#import "UIDevice+IdentifierAddition.h"
#import "CookieManager.h"
#import "User.h"
#import "KTCMapService.h"

NSString *const CookieDomain         = @".kidstc.com";
NSString *const CookieKey_uid        = @"uid";
NSString *const CookieKey_skey       = @"skey";
NSString *const CookieKey_appversion = @"appversion";      //app的版本号
NSString *const CookieKey_deviceid   = @"deviceId";
NSString *const CookieKey_appsource  = @"appsource";
NSString *const CookieKey_app        = @"app";
NSString *const CookieKey_mapaddr    = @"mapaddr";         //地理位置信息
NSString *const CookieKeyUserRole    = @"population_type"; //用户角色
NSString *const CookieKeyGuid        = @"guid";

@implementation CookieManager
singleM(CookieManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        [NotificationCenter addObserver:self selector:@selector(mapaddrDidChange) name:kUserLocationHasChangedNotification object:nil];
    }
    return self;
}

-(void)setCookies{
    
    [self setCookieWithName:CookieKey_uid andValue:[User shareUser].uid];
    [self setCookieWithName:CookieKey_skey andValue:[User shareUser].skey];
    [self setCookieWithName:CookieKey_appversion andValue:APP_VERSION];
    [self setCookieWithName:CookieKey_deviceid andValue:[[UIDevice currentDevice] uniqueDeviceIdentifier]];
    [self setCookieWithName:CookieKey_appsource andValue:@"iPhone"];
    [self setCookieWithName:CookieKey_app andValue:@"1"];
    [self setCookieWithName:CookieKey_mapaddr andValue:[KTCMapService shareKTCMapService].currentLocationString];
    [self setCookieWithName:CookieKeyUserRole andValue:[User shareUser].role.roleIdentifierString];
}
- (void)setCookieWithName:(NSString *)name andValue:(NSString *)value
{
    if (!name || !value) return;
    NSDictionary *propertiesKidsTC = [NSDictionary dictionaryWithObjectsAndKeys:
                                      name, NSHTTPCookieName,
                                      value, NSHTTPCookieValue,
                                      @"/", NSHTTPCookiePath,
                                      CookieDomain, NSHTTPCookieDomain, nil];
    NSHTTPCookie *kisTCCookie = [NSHTTPCookie cookieWithProperties:propertiesKidsTC];
    //set cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:kisTCCookie];
}

- (void)deleteCookieWithName:(NSString *)name
{
    if (!name) {
        return;
    }
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies])
    {
        if ([cookie.name isEqualToString:name]) {
            [storage deleteCookie:cookie];
        }
    }
}

- (void)mapaddrDidChange{
    [self setCookieWithName:CookieKey_mapaddr andValue:[KTCMapService shareKTCMapService].currentLocationString];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}
@end
