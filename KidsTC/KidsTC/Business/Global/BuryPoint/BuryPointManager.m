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
#import "CookieManager.h"
#import "DataBaseManager.h"
#import "BuryPointTrackModel.h"

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
@property (nonatomic, assign) BOOL isLanch;

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *appDevice;
@property (nonatomic, strong) NSString *appv;
@property (nonatomic, strong) NSString *build;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSDictionary *deviceInfo;
@end
@implementation BuryPointManager
singleM(BuryPointManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        _isLanch = YES;
        
        _projectId = @"1";
        _deviceId = [[UIDevice currentDevice] uniqueDeviceIdentifier];
        _appDevice = [NSString stringWithFormat:@"%zd",AppDeviceTypeIOS];
        _appv = APP_VERSION;
        _build = @"1";
        _channel = @"appStore";
        
        CGFloat scale = [UIScreen mainScreen].scale;
        NSString *resolu = [NSString stringWithFormat:@"%zdx%zd",SCREEN_WIDTH*scale,SCREEN_HEIGHT*scale];
        NSString *device = [[UIDevice currentDevice] machineModelName];
        NSString *osv = [NSString stringWithFormat:@"%0.2f",[UIDevice systemVersion]];
        _deviceInfo = @{@"resolu":resolu,@"device":device,@"osv":osv};
    }
    return self;
}

+ (void)startBuryPoint
{
    [self registerUmeng];
    
    TCLog(@"manager.guid:%@",[BuryPointManager shareBuryPointManager].guid);
}

+ (void)trackBegin:(long)pageId pageUid:(NSString *)pageUid pageName:(NSString *)pageName params:(NSDictionary *)params
{
    if([pageName isNotNull])[MobClick beginLogPageView:pageName];
    if(pageId>0)[self reportMsgTrackType:TrackTypePV beginPV:YES actionId:pageId pageUid:pageUid params:params];
}

+ (void)trackEnd:(long)pageId pageUid:(NSString *)pageUid pageName:(NSString *)pageName params:(NSDictionary *)params
{
    if([pageName isNotNull])[MobClick endLogPageView:pageName];
    if(pageId>0)[self trackSite:[self reportMsgTrackType:TrackTypePV beginPV:NO actionId:pageId pageUid:pageUid params:params]];
}

+ (void)trackEvent:(NSString *)eventName actionId:(long)actionId params:(NSDictionary *)params
{
    if([eventName isNotNull])[MobClick event:eventName attributes:params];
    if(actionId>0)[self trackSite:[self reportMsgTrackType:TrackTypeEvent beginPV:NO actionId:actionId pageUid:nil params:params]];
}

#pragma mark - private

- (NSString *)guid{
    BuryPointManager *manager = [BuryPointManager shareBuryPointManager];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval stayTimeInterval = timeInterval - manager.lastProductGuidTimeInterval;
    if (!_guid || stayTimeInterval > 30 * 60) {
        _guid = [UIDevice uuidString];
        _squence = 0;
        [[CookieManager shareCookieManager] setCookieWithName:CookieKeyGuid andValue:_guid];
        manager.lastProductGuidTimeInterval = timeInterval;
        if (stayTimeInterval>0) {
            [BuryPointManager trackCommon];
        }
    }
    return _guid;
}

+ (void)registerUmeng {
    UMConfigInstance.appKey = @"57625e6f67e58ea042003764";
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:APP_VERSION];
    [MobClick startWithConfigure:UMConfigInstance];
#ifdef DEBUG
    [MobClick setLogEnabled:NO];
#else
    [MobClick setLogEnabled:NO];
#endif
}

+ (void)trackCommon {
    NSString *reportMsg = [[self shareBuryPointManager] reportMsgCommon];
    if (![reportMsg isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"reportMsg":reportMsg};
    [Request startAndCallBackInChildThreadWithName:@"REPORT_DEVICE_INFO" param:param success:nil failure:nil];
}

+ (void)trackSite:(BuryPointModel *)model {
    if (!model) return;
    DataBaseManager *db = [DataBaseManager shareDataBaseManager];
    [db buryPoint_inset:model successBlock:^(BOOL success) {
        if (success) [self track];
    }];
}

static NSInteger errorCount = 0;
+ (void)track {
    DataBaseManager *db = [DataBaseManager shareDataBaseManager];
    [db buryPoint_not_upload_count:^(NSUInteger count) {
        if (count<20) return;
        [db buryPoint_not_upload_allModels:^(NSArray<BuryPointModel *> *models) {
            NSUInteger pageCount = 20;
            __block NSUInteger page = 0;
            NSUInteger len = pageCount;
            __block NSUInteger loc = page*pageCount;
            __block NSUInteger needCount = loc + len;
            __block NSRange range  = NSMakeRange(loc, len);
            while (needCount<models.count) {
                
                NSArray<BuryPointModel *> *sendModels = [models subarrayWithRange:range];
                NSMutableArray *ary = [NSMutableArray array];
                [sendModels enumerateObjectsUsingBlock:^(BuryPointModel *obj, NSUInteger idx, BOOL *stop) {
                    NSString *content = obj.content;
                    if ([content isNotNull]) {
                        NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
                        if (data) {
                            NSError *error_dic = nil;
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error_dic];
                            if (!error_dic && dic && [dic isKindOfClass:[NSDictionary class]] && dic.count>0) {
                                [ary addObject:dic];
                            }
                        }
                    };
                }];
                NSString *msg = [[self shareBuryPointManager] jsonWithObj:ary];
                errorCount = 0;
                [self uploadTrack:msg successBlock:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                    BuryPointTrackModel *model = [BuryPointTrackModel modelWithDictionary:dic];
                    NSArray<NSString *> *Lst = model.data.Lst;
                    for (BuryPointModel *obj in sendModels) {
                        __block BOOL has = NO;
                        for (NSString *errorPKStr in Lst) {
                            if (has) continue;
                            if ([errorPKStr isEqualToString:obj.pk]) has = YES;
                        }
                        if (has) continue;
                        [db buryPoint_delete:obj successBlock:^(BOOL success_delete) {
                            TCLog(@"埋点上传成功……开始删除……pk:%@",obj.pk);
                            if (success_delete) {
                                TCLog(@"埋点上传成功……删除成功……");
                                obj.status = YES;
                                [db buryPoint_inset_did_upload:obj successBlock:^(BOOL success_insert) {
                                    if (success_insert) {
                                        TCLog(@"埋点上传成功……删除成功……插入新表成功……");
                                    }else{
                                        TCLog(@"埋点上传成功……删除成功……插入新表失败……");
                                    }
                                }];
                            }else{
                                TCLog(@"埋点上传成功……删除失败……");
                            }
                        }];
                    }
                } failureBlock:^{
                    TCLog(@"埋点上传失败……删除失败……重试3次之后任然失败");
                }];
                page++;
                loc = page*pageCount;
                needCount = loc + len;
                range = NSMakeRange(loc, len);
            }
        }];
    }];
}

+ (void)uploadTrack:(NSString *)msg successBlock:(void(^)(NSURLSessionDataTask *task, NSDictionary *dic))successBlock failureBlock:(void(^)())failureBlock {
    if (![msg isNotNull]) {
        if(failureBlock)failureBlock();
        return;
    };
    NSDictionary *param = @{@"reportMsg":msg};
    [Request startAndCallBackInChildThreadWithName:@"SITE_STATISTICS_APP" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(successBlock)successBlock(task,dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        errorCount ++;
        if (errorCount<4) {
            //NSString *tip = [NSString stringWithFormat:@"埋点上传失败……删除失败……已重试%zd次",errorCount];
            //TCLog(@"%@",tip);
            [self uploadTrack:msg successBlock:successBlock failureBlock:failureBlock];
        }else{
            if(failureBlock)failureBlock();
        }
    }];
}

- (NSString *)reportMsgCommon {
    NSString *guid = self.guid;
    NSString *mapAddr = [KTCMapService shareKTCMapService].currentLocationString;
    NSString *ip = [NSString deviceIPAdress];
    NSDictionary *reportMsgDic = @{@"guid":guid,
                                   @"projectId":_projectId,
                                   @"deviceId":_deviceId,
                                   @"appDevice":_appDevice,
                                   @"appv":_appv,
                                   @"build":_build,
                                   @"channel":_channel,
                                   @"mapAddr":mapAddr,
                                   @"ip":ip,
                                   @"deviceInfo":_deviceInfo};
    NSString *msg = [NSString zp_stringWithJsonObj:reportMsgDic];
    if (![msg isNotNull]) msg = @"";
    return msg;
}

+ (BuryPointModel *)reportMsgTrackType:(TrackType)trackType beginPV:(BOOL)beginPV actionId:(long)actionId pageUid:(NSString *)pageUid params:(NSDictionary *)dic
{
    BuryPointManager *manager = [BuryPointManager shareBuryPointManager];
    NSString *type = [NSString stringWithFormat:@"%zd",trackType];
    NSString *net = [NSString stringWithFormat:@"%zd",[self NetworkStatusTo]];
    NSString *guid = manager.guid;
    NSString *uid = [User shareUser].uid;
    NSString *squence = [NSString stringWithFormat:@"%zd",manager.squence++];
    NSString *deviceId = manager.deviceId;
    NSString *clientIp = [NSString deviceIPAdress];
    NSNumber *actionID = [NSNumber numberWithLong:actionId];
    NSMutableDictionary *reportMsgDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:type,@"type",net,@"net" ,guid,@"guid",actionID,@"actionId",uid,@"uid",squence,@"squence",deviceId,@"deviceId",clientIp,@"clientIp",nil];
    if (dic && [dic isKindOfClass:[NSDictionary class]] && dic.count>0) {
        NSString *paramsStr = [manager jsonWithObj:dic];
        if ([paramsStr isNotNull])[reportMsgDic setValue:paramsStr forKey:@"params"];
    }
    if (trackType == TrackTypePV) {
        NSNumber *stayTime = [NSNumber numberWithLongLong:0];
        if (beginPV) {
            manager.lastBeginPvTimeInterval = [[NSDate date] timeIntervalSince1970];
        }else{
            NSTimeInterval stayTimeInterval = [[NSDate date] timeIntervalSince1970] - manager.lastBeginPvTimeInterval;
            stayTime = [NSNumber numberWithLongLong:stayTimeInterval*1000];
        }
        [reportMsgDic setValue:stayTime forKey:@"stayTime"];
        if([pageUid isNotNull])[reportMsgDic setValue:pageUid forKey:@"pageUid"];
    }
    long long pk = arc4random()%10000000000;
    NSString *pkMD5String = [NSString stringWithFormat:@"%@",@(pk)].md5String;
    if ([pkMD5String isNotNull]) [reportMsgDic setObject:pkMD5String forKey:@"pk"];
    NSString *msg = [manager jsonWithObj:reportMsgDic];
    BuryPointModel *mdoel = [BuryPointModel modelWithPk:pkMD5String content:msg];
    return mdoel;
}

- (NSString *)jsonWithObj:(id)obj{
    if (obj == nil) return nil;
    NSError *err;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:obj options:0 error:&err];
    if(err) {
        TCLog(@"字典转JSON失败：%@",err);
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
