//
//  Request.h
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Progress)(NSProgress * progress);
typedef void (^SuccessBlock)(NSURLSessionDataTask *task, NSDictionary *dic);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface Request : NSObject
/**
 *  开始请求
 *
 *  @param name     请求别名
 *  @param param    请求参数
 *  @param progress 响应进度
 *  @param success  成功 在主线程回调
 *  @param failure  失败 在主线程回调
 */
+ (void)startWithName:(NSString *)name
                param:(NSDictionary *)param
             progress:(Progress)progress
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;
/**
 *  开始请求
 *
 *  @param name     请求别名
 *  @param param    请求参数
 *  @param progress 响应进度
 *  @param success  成功 在子线程回调
 *  @param failure  失败 在子线程回调
 */
+ (void)startAndCallBackInChildThreadWithName:(NSString *)name
                                        param:(NSDictionary *)param
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure;
/**
 *  开始请求
 *
 *  @param name     请求别名
 *  @param param    请求参数
 *  @param success  成功 在当前线程回调
 *  @param failure  失败 在当前程回调
 */
+ (void)startSyncName:(NSString *)name
                param:(NSDictionary *)param
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;
/**
 *  下载图片
 *
 *  @param urlStr  图片地址
 *  @param success 成功 主线程回调
 *  @param failure 失败 主线程回调
 */
+ (void)dowloadImgWithUrlStr:(NSString *)urlStr
                     success:(void (^)(NSURLSessionDataTask *task,NSData *data))success
                     failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;

/**
 *  专门用作检查App版本跟新
 *
 *  @param name     请求别名
 *  @param param    请求参数
 *  @param progress 响应进度
 *  @param success  成功 在主线程回调
 *  @param failure  失败 在主线程回调
 */
+ (void)checkVersionWithName:(NSString *)name
                       param:(NSDictionary *)param
                    progress:(Progress)progress
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;
@end
