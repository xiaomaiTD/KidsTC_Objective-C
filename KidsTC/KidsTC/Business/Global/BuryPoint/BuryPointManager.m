//
//  BuryPointManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "BuryPointManager.h"
#import "UMMobClick/MobClick.h"
#import "GHeader.h"
#import "UIDevice+IdentifierAddition.h"
#import "KTCMapService.h"
#import "NSString+Category.h"
#import "NSString+ZP.h"
#import "YYKit.h"
#import "ReachabilityManager.h"

//设备类型
typedef enum : NSUInteger {
    AppDeviceTypeAndroid = 1,
    AppDeviceTypeIOS = 2,
    AppDeviceTypeHtml5 = 3,
    AppDeviceTypeWebSite = 4,
    AppDeviceTypeIOSIPad = 5,
    AppDeviceTypeAndroidIPad = 6
} AppDeviceType;

//网络类型
typedef enum : NSUInteger {
    NetTypeNone = 0,
    NetTypeWIFI = 1,
    NetType2G = 2,
    NetType3G = 3,
    NetType4G = 4,
    NetType5G = 5,
} NetType;

//上报类型
typedef enum : NSUInteger {
    TrackTypePV = 1,//PV
    TrackTypeEvent = 2,//事件
} TrackType;

@interface BuryPointManager ()
@property (nonatomic, assign) NSTimeInterval lastProductGuidTimeInterval;
@property (nonatomic, assign) NSTimeInterval lastBeginPvTimeInterval;
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, assign) NSUInteger squence;//访问顺序
@end
@implementation BuryPointManager
singleM(BuryPointManager)

+ (void)startBuryPoint
{
    [self registerUmeng];
    
    [self trackCommon];
}

+ (void)trackBegin:(long)pageId
           pageUid:(NSString *)pageUid
          pageName:(NSString *)pageName
{
    if([pageName isNotNull])[MobClick beginLogPageView:pageName];
    if(pageId>0)[self trackSite:[self reportMsgTrackType:TrackTypePV
                                                 beginPV:YES
                                                actionId:pageId
                                                 pageUid:pageUid
                                                  params:nil]];
    
}

+ (void)trackEnd:(long)pageId
         pageUid:(NSString *)pageUid
        pageName:(NSString *)pageName
{
    if([pageName isNotNull])[MobClick endLogPageView:pageName];
    if(pageId>0)[self trackSite:[self reportMsgTrackType:TrackTypePV
                                                 beginPV:NO
                                                actionId:pageId
                                                 pageUid:pageUid
                                                  params:nil]];
}

+ (void)trackEvent:(NSString *)eventName
          actionId:(long)actionId
            params:(NSDictionary *)params
{
    if([eventName isNotNull])[MobClick event:eventName attributes:params];
    if(actionId>0)[self trackSite:[self reportMsgTrackType:TrackTypeEvent
                                                   beginPV:NO
                                                  actionId:actionId
                                                   pageUid:nil
                                                    params:params]];
    
}

#pragma mark - private

- (NSString *)guid{
    BuryPointManager *manager = [BuryPointManager shareBuryPointManager];
    NSTimeInterval stayTimeInterval = [[NSDate date] timeIntervalSince1970] - manager.lastProductGuidTimeInterval;
    if (!_guid || stayTimeInterval > 30 * 60) {
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSString *projectId = @"1";
        NSString *deviceId = [[UIDevice currentDevice] uniqueDeviceIdentifier];
        NSNumber *timeTag = [NSNumber numberWithLongLong:timeInterval];
        _guid = [NSString stringWithFormat:@"%@#%@#%@",projectId,deviceId,timeTag];
        _squence = 0;
        if (manager.lastProductGuidTimeInterval>0) {
            [BuryPointManager trackCommon];
        }
        manager.lastProductGuidTimeInterval = timeInterval;
    }
    return _guid;
}

+ (void)registerUmeng {
    UMConfigInstance.appKey = @"57625e6f67e58ea042003764";
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:APP_VERSION];
    [MobClick startWithConfigure:UMConfigInstance];
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#else
    [MobClick setLogEnabled:NO];
#endif
}

+ (void)trackCommon {
    NSString *reportMsg = [[BuryPointManager shareBuryPointManager] reportMsgCommon];
    if (![reportMsg isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"reportMsg":reportMsg};
    [Request startAndCallBackInChildThreadWithName:@"REPORT_DEVICE_INFO" param:param success:nil failure:nil];
}

+ (void)trackSite:(NSString *)reportMsg {
    if (![reportMsg isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"reportMsg":reportMsg};
    [Request startAndCallBackInChildThreadWithName:@"SITE_STATISTICS_APP" param:param success:nil failure:nil];
}

- (NSString *)reportMsgCommon {
    NSString *guid = self.guid;
    NSString *projectId = @"1";
    NSString *deviceId = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSString *appDevice = [NSString stringWithFormat:@"%zd",AppDeviceTypeIOS];
    NSString *appv = APP_VERSION;
    NSString *build = @"1";
    NSString *channel = @"appStore";
    NSString *mapAddr = [KTCMapService shareKTCMapService].currentLocationString;
    NSString *ip = [NSString deviceIPAdress];
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *resolu = [NSString stringWithFormat:@"%zdx%zd",SCREEN_WIDTH*scale,SCREEN_HEIGHT*scale];
    NSString *device = [[UIDevice currentDevice] machineModelName];
    NSString *osv = [NSString stringWithFormat:@"%0.2f",[UIDevice systemVersion]];
    NSDictionary *deviceInfo = @{@"resolu":resolu,
                                 @"device":device,
                                 @"osv":osv};
    NSDictionary *reportMsgDic = @{@"guid":guid,
                                   @"projectId":projectId,
                                   @"deviceId":deviceId,
                                   @"appDevice":appDevice,
                                   @"appv":appv,
                                   @"build":build,
                                   @"channel":channel,
                                   @"mapAddr":mapAddr,
                                   @"ip":ip,
                                   @"deviceInfo":deviceInfo};
    NSString *msg = [NSString zp_stringWithDictory:reportMsgDic];
    if (![msg isNotNull]) msg = @"";
    return msg;
}

+ (NSString *)reportMsgTrackType:(TrackType)trackType
                         beginPV:(BOOL)beginPV
                        actionId:(long)actionId
                         pageUid:(NSString *)pageUid
                          params:(NSDictionary *)dic
{
    BuryPointManager *manager = [BuryPointManager shareBuryPointManager];
    NSString *type = [NSString stringWithFormat:@"%zd",trackType];
    NSString *net = [NSString stringWithFormat:@"%zd",[self NetworkStatusTo]];
    NSString *guid = manager.guid;
    NSString *uid = [User shareUser].uid;
    NSString *squence = [NSString stringWithFormat:@"%zd",manager.squence++];
    NSString *deviceId = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSString *clientIp = [NSString deviceIPAdress];
    NSMutableDictionary *reportMsgDic =  [@{@"type":type,
                                            @"net":net,
                                            @"guid":guid,
                                            @"actionId":@(actionId),
                                            @"uid":uid,
                                            @"squence":squence,
                                            @"deviceId":deviceId,
                                            @"clientIp":clientIp} mutableCopy];
    if (dic && [dic isKindOfClass:[NSDictionary class]] && dic.count>0) {
        NSDictionary *params = [NSDictionary dictionaryWithDictionary:dic];
        [reportMsgDic setValue:params forKey:@"params"];
    }
    switch (trackType) {
        case TrackTypePV:
        {
            long long stayTime = 0;
            if (beginPV) {
                manager.lastBeginPvTimeInterval = [[NSDate date] timeIntervalSince1970];
            }else{
                NSTimeInterval stayTimeInterval = [[NSDate date] timeIntervalSince1970] - manager.lastBeginPvTimeInterval;
                stayTime = stayTimeInterval*1000;
            }
            [reportMsgDic setValue:@(stayTime) forKey:@"stayTime"];
            if([pageUid isNotNull])[reportMsgDic setValue:pageUid forKey:@"pageUid"];
        }
            break;
        case TrackTypeEvent:
        {
            
        }
            break;
    }
    NSArray *ary = @[reportMsgDic];
    NSString *msg = [manager jsonWithObj:ary];
    if (![msg isNotNull]) msg = @"";
    return msg;
}

- (NSString *)jsonWithObj:(id)obj{
    if (obj == nil) {
        return nil;
    }
    NSError *err;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:obj options:0 error:&err];
    if(err) {
        NSLog(@"字典转JSON失败：%@",err);
        return nil;
    }
    NSString *jsonString_utf8=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString_utf8;
}

+ (NetType)NetworkStatusTo{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            TCLog(@"No wifi or cellular");
            return NetTypeNone;
            break;
            
        case 1:
            TCLog(@"2G");
            return NetType2G;
            break;
            
        case 2:
            TCLog(@"3G");
            return NetType3G;
            break;
            
        case 3:
            TCLog(@"4G");
            return NetType4G;
            break;
            
        case 4:
            TCLog(@"LTE");
            return NetTypeNone;
            break;
            
        case 5:
            TCLog(@"Wifi");
            return NetTypeWIFI;
            break;
            
        default:
        {
            return NetTypeNone;
        }
            break;
    }
}



@end
