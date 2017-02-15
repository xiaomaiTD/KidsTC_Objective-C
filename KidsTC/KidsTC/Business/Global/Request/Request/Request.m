//
//  Request.m
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "Request.h"
#import "Macro.h"
#import "InterfaceManager.h"
#import "AFNetworking.h"
#import "CookieManager.h"
#import "DataBaseManager.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"
#import "NSString+ZP.h"

static Request *_requestManager;

@interface Request ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *downloadSessionManager;
@end

@implementation Request

+ (Request *)shareRequestManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestManager = [[self alloc]init];
        _requestManager.sessionManager = [AFHTTPSessionManager manager];
        _requestManager.sessionManager.responseSerializer =[AFHTTPResponseSerializer serializer];
        [_requestManager.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"KidsTC/Iphone/%@", APP_VERSION] forHTTPHeaderField:@"User-Agent"];
        
        _requestManager.downloadSessionManager = [AFHTTPSessionManager manager];
        _requestManager.downloadSessionManager.responseSerializer =[AFHTTPResponseSerializer serializer];
        [_requestManager.downloadSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"KidsTC/Iphone/%@", APP_VERSION] forHTTPHeaderField:@"User-Agent"];
    });
    return _requestManager;
}

+ (void)startWithName:(NSString *)name
                param:(NSDictionary *)param
             progress:(Progress)progress
              success:(SuccessBlock)success
              failure:(FailureBlock)failure
{
    InterfaceItem *interfaceItem = [[InterfaceManager shareInterfaceManager] interfaceItemWithName:name];
    if (!interfaceItem) {
        if (failure) failure(nil,nil);
        return;
    };
    [[CookieManager shareCookieManager] checkUid];
    AFHTTPSessionManager *manager = [self shareRequestManager].sessionManager;
    //[manager.requestSerializer setValue:@"UTF"forHTTPHeaderField:@"Charset"];
    switch (interfaceItem.method) {
        case RequestTypeGet:
        {
            interfaceItem.start = [[NSDate date] timeIntervalSince1970];
            [manager GET:interfaceItem.url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self responseSuccessWithInterfaceItem:interfaceItem task:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self responseFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
            }];
        }
            break;
        case RequestTypePost:
        {
            interfaceItem.start = [[NSDate date] timeIntervalSince1970];
            [manager POST:interfaceItem.url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) progress(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self responseSuccessWithInterfaceItem:interfaceItem task:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self responseFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
            }];
        }
            break;
            default:
        {
            if (failure) failure(nil,nil);
            return;
        }
            break;
    }
}

+ (void)startAndCallBackInChildThreadWithName:(NSString *)name
                                        param:(NSDictionary *)param
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure
{
    InterfaceItem *interfaceItem = [[InterfaceManager shareInterfaceManager] interfaceItemWithName:name];
    if (!interfaceItem) {
        if (failure) failure(nil,nil);
        return;
    };
    [[CookieManager shareCookieManager] checkUid];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlStr = nil;
    NSString *HTTPMethod = nil;
    NSData *HTTPBody = nil;
    switch (interfaceItem.method) {
        case RequestTypeGet:
        {
            urlStr = [NSString stringWithFormat:@"%@%@",interfaceItem.url,[self paramString:param]];
            HTTPMethod = @"GET";
        }
            break;
        case RequestTypePost:
        {
            urlStr = interfaceItem.url;
            HTTPMethod = @"POST";
            HTTPBody = [[self paramString:param] dataUsingEncoding:NSUTF8StringEncoding];
        }
            break;
        default:
        {
            if (failure) failure(nil,nil);
            return;
        }
            break;
    }
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = HTTPMethod;
    request.HTTPBody = HTTPBody;
    [request setValue:[NSString stringWithFormat:@"KidsTC/Iphone/%@", APP_VERSION] forHTTPHeaderField:@"User-Agent"];
    interfaceItem.start = [[NSDate date] timeIntervalSince1970];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self responseSuccessWithInterfaceItem:interfaceItem task:task responseObject:data success:success failure:failure];
        }else{
            [self responseFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
        }
    }];
    [task resume];
}

+ (void)startSyncName:(NSString *)name
                param:(NSDictionary *)param
              success:(SuccessBlock)success
              failure:(FailureBlock)failure
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    InterfaceItem *interfaceItem = [[InterfaceManager shareInterfaceManager] interfaceItemWithName:name];
    if (!interfaceItem) {
        if (failure) failure(nil,nil);
        return;
    };
    [[CookieManager shareCookieManager] checkUid];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlStr = nil;
    NSString *HTTPMethod = nil;
    NSData *HTTPBody = nil;
    switch (interfaceItem.method) {
        case RequestTypeGet:
        {
            urlStr = [NSString stringWithFormat:@"%@%@",interfaceItem.url,[self paramString:param]];
            HTTPMethod = @"GET";
        }
            break;
        case RequestTypePost:
        {
            urlStr = interfaceItem.url;
            HTTPMethod = @"POST";
            HTTPBody = [[self paramString:param] dataUsingEncoding:NSUTF8StringEncoding];
        }
            break;
        default:
        {
            if (failure) failure(nil,nil);
            return;
        }
            break;
    }
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = HTTPMethod;
    request.HTTPBody = HTTPBody;
    [request setValue:[NSString stringWithFormat:@"KidsTC/Iphone/%@", APP_VERSION] forHTTPHeaderField:@"User-Agent"];
    interfaceItem.start = [[NSDate date] timeIntervalSince1970];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self responseSuccessWithInterfaceItem:interfaceItem task:task responseObject:data success:success failure:failure];
        }else{
            [self responseFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
        }
        dispatch_semaphore_signal(semaphore);   //发送信号
    }];
    [task resume];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);//等待
}

+ (void)dowloadImgWithUrlStr:(NSString *)urlStr
                     success:(void (^)(NSURLSessionDataTask *task,NSData *data))success
                     failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
{
    AFHTTPSessionManager *manager = [self shareRequestManager].downloadSessionManager;
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(task,error);
    }];
}

/**
 *  响应成功
 */
+(void)responseSuccessWithInterfaceItem:(InterfaceItem *)interfaceItem
                                   task:(NSURLSessionDataTask *)task
                         responseObject:(id)responseObject
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure

{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    if ([dic[@"errno"] respondsToSelector:@selector(integerValue)]) {
        NSInteger errNo = [dic[@"errno"] integerValue];
        if (errNo == 0) {//如果errNo为0，则为请求成功
            TCLog(@"响应成功-success-:%@\n响应报文:%@\n",interfaceItem,dic);
            if (success) success(task,dic);
            if (success) success = nil;
        }else{//否则全部按照请求失败处理
            if (errNo == -1000) {//如果请求失败，并且请求errNo为-1000，则使用户自动退出登录
                [[User shareUser] logoutManually:NO withSuccess:nil failure:nil];
            }
            NSError *error = [NSError errorWithDomain:@"Http request" code:errNo userInfo:dic];
            TCLog(@"响应成功-(但errno非0，按照请求失败来处理)-failure-:%@\n响应报文:%@\n",interfaceItem,error);
            if (failure) failure(task,error);
            if (failure) failure = nil;
        }
    }else{
        NSError *error = [NSError errorWithDomain:@"Http request" code:-1 userInfo:dic];
        TCLog(@"响应成功-(但errno不是int类型，按照请求失败来处理)-failure-:%@\n响应报文:%@\n",interfaceItem,error);
        if (failure) failure(task,error);
        if (failure) failure = nil;
    }
    interfaceItem.end = [[NSDate date] timeIntervalSince1970];
    [Request getStatusCodeItem:interfaceItem task:task];
}

/**
 *  响应失败
 */
+(void)responseFailureWithInterfaceItem:(InterfaceItem *)interfaceItem
                                   task:(NSURLSessionDataTask *)task
                                  error:(NSError *)error
                                failure:(FailureBlock)failure
{
    TCLog(@"响应失败-failure-:%@\n错误报文:%@\n",interfaceItem,error);
    if (failure) failure(task,error);
    if (failure) failure = nil;
    interfaceItem.end = [[NSDate date] timeIntervalSince1970];
    [Request getStatusCodeItem:interfaceItem task:task];
}




+ (void)checkVersionWithName:(NSString *)name
                       param:(NSDictionary *)param
                    progress:(Progress)progress
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure
{
    InterfaceItem *interfaceItem = [[InterfaceManager shareInterfaceManager] interfaceItemWithName:name];
    if (!interfaceItem) {
        if (failure) failure(nil,nil);
        return;
    };
    [[CookieManager shareCookieManager] checkUid];
    AFHTTPSessionManager *manager = [self shareRequestManager].sessionManager;
    switch (interfaceItem.method) {
        case RequestTypeGet:
        {
            interfaceItem.start = [[NSDate date] timeIntervalSince1970];
            [manager GET:interfaceItem.url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self checkVersionSuccessWithInterfaceItem:interfaceItem task:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self checkVersionFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
            }];
        }
            break;
        case RequestTypePost:
        {
            interfaceItem.start = [[NSDate date] timeIntervalSince1970];
            [manager POST:interfaceItem.url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) progress(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self checkVersionSuccessWithInterfaceItem:interfaceItem task:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self checkVersionFailureWithInterfaceItem:interfaceItem task:task error:error failure:failure];
            }];
        }
            break;
        default:
        {
            if (failure) failure(nil,nil);
            return;
        }
            break;
    }
}

/**
 *  响应成功
 */
+(void)checkVersionSuccessWithInterfaceItem:(InterfaceItem *)interfaceItem
                                   task:(NSURLSessionDataTask *)task
                         responseObject:(id)responseObject
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure

{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    if ([dic[@"Code"] respondsToSelector:@selector(integerValue)]) {
        NSInteger Code = [dic[@"Code"] integerValue];
        if (Code == 0) {//如果errNo为0，则为请求成功
            TCLog(@"响应成功-success-:%@\n响应报文:%@\n",interfaceItem,dic);
            if (success) success(task,dic);
            if (success) success = nil;
        }else{//否则全部按照请求失败处理
            if (Code == -1000) {//如果请求失败，并且请求errNo为-1000，则使用户自动退出登录
                [[User shareUser] logoutManually:NO withSuccess:nil failure:nil];
            }
            NSError *error = [NSError errorWithDomain:@"Http request" code:Code userInfo:dic];
            TCLog(@"响应成功-(但errno非0，按照请求失败来处理)-failure-:%@\n响应报文:%@\n",interfaceItem,error);
            if (failure) failure(task,error);
            if (failure) failure = nil;
        }
    }else{
        NSError *error = [NSError errorWithDomain:@"Http request" code:-1 userInfo:dic];
        TCLog(@"响应成功-(但errno不是int类型，按照请求失败来处理)-failure-:%@\n响应报文:%@\n",interfaceItem,error);
        if (failure) failure(task,error);
        if (failure) failure = nil;
    }
    interfaceItem.end = [[NSDate date] timeIntervalSince1970];
    [Request getStatusCodeItem:interfaceItem task:task];
}

/**
 *  响应失败
 */
+(void)checkVersionFailureWithInterfaceItem:(InterfaceItem *)interfaceItem
                                   task:(NSURLSessionDataTask *)task
                                  error:(NSError *)error
                                failure:(FailureBlock)failure
{
    TCLog(@"响应失败-failure-:%@\n错误报文:%@\n",interfaceItem,error);
    if (failure) failure(task,error);
    if (failure) failure = nil;
    interfaceItem.end = [[NSDate date] timeIntervalSince1970];
    [Request getStatusCodeItem:interfaceItem task:task];
}

#pragma mark - helpers

+ (NSString *)paramString:(NSDictionary *)parameters{
    if (!parameters || ![parameters isKindOfClass:[NSDictionary class]]) return @"";
    NSMutableString *str = [NSMutableString string];
    NSArray *keys = parameters.allKeys;
    NSUInteger count = keys.count;
    for (int i = 0; i<count; i++) {
        NSString *key = keys[i];
        NSString *value = parameters[key];
        NSMutableString *item = [NSMutableString stringWithFormat:@"&%@=%@",key,value];
        [str appendString:item];
    }
    return str;
}

+ (void)getStatusCodeItem:(InterfaceItem *)interfaceItem
                     task:(NSURLSessionDataTask *)task
{
    NSString *urlTag = interfaceItem.name;
    if (![urlTag isNotNull]) return;
    
    NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
    NSInteger netCode = responses.statusCode;
    long long time = (interfaceItem.end - interfaceItem.start)*1000;
    
    NSDictionary *allHeaderFields = responses.allHeaderFields;
    id date = allHeaderFields[@"Date"];
    id last_Modified = allHeaderFields[@"Last-Modified"];
    if (date && last_Modified && [date isKindOfClass:[NSDate class]] && [last_Modified isKindOfClass:[NSDate class]]) {
        NSTimeInterval date_time = [date timeIntervalSince1970];
        NSTimeInterval last_Modified_time = [last_Modified timeIntervalSince1970];
        time = (last_Modified_time - date_time)*1000;
    }
    
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    [content setObject:@(time) forKey:@"apiCellTime"];
    NetType netType = [BuryPointManager NetworkStatusTo];
    [content setObject:@(netType) forKey:@"networkType"];
    [content setObject:@(netCode) forKey:@"httpStatusCode"];
    [content setObject:@(2) forKey:@"channel"];
    if ([urlTag isNotNull]) {
        [content setObject:urlTag forKey:@"urlTag"];
    }
    long long pk = arc4random()%10000000000;
    NSString *pkMD5String = [NSString stringWithFormat:@"%@",@(pk)].md5String;
    if ([pkMD5String isNotNull]) {
        [content setObject:pkMD5String forKey:@"pk"];
    }
    
    NSString *str = [NSString zp_stringWithJsonObj:content];
    if ([str isNotNull]) {
        BuryPointModel *model = [BuryPointModel new];
        model.content = str;
        DataBaseManager *man = [DataBaseManager shareDataBaseManager];
        [man request_inset:model successBlock:^(BOOL success) {
            [man request_not_upload_count:^(NSUInteger count) {
                if (count<50) return ;
                [man request_not_upload_allModels:^(NSArray<BuryPointModel *> *models) {
                    if (models.count<1) return;
                    NSMutableArray *ary = [NSMutableArray array];
                    [models enumerateObjectsUsingBlock:^(BuryPointModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj.content isNotNull]) {
                            NSData *data = [obj.content dataUsingEncoding:NSUTF8StringEncoding];
                            if (data) {
                                NSError *error_dic = nil;
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error_dic];
                                if (!error_dic && dic && [dic isKindOfClass:[NSDictionary class]] && dic.count>0) {
                                    [ary addObject:dic];
                                }
                            };
                        }
                    }];
                    NSString *aryStr = [NSString zp_stringWithJsonObj:ary];
                    if (![aryStr isNotNull]) return;
                    NSDictionary *param = @{@"reportMsg":aryStr};
                    [Request startWithName:@"REPORT_API_CELL_TIME" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
                        [self deleteRequest_not_upload];
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        [self deleteRequest_not_upload];
                    }];
                }];
            }];
        }];
    }
}

+ (void)deleteRequest_not_upload {
    [[DataBaseManager shareDataBaseManager] request_not_upload_allModels_deleteSuccessBlock:^(BOOL success) {
        if (success) {
            TCLog(@"request_not_upload_allModels批量删除成功...");
        }else{
            TCLog(@"request_not_upload_allModels批量删除失败...");
        }
    }];
}


@end
