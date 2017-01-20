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

@end
