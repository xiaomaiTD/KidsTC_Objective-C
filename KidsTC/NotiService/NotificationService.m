//
//  NotificationService.m
//  NotiService
//
//  Created by 詹平 on 2016/10/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NotificationService.h"

static NSString *const kTcMedias = @"tcMedias";

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    NSDictionary *dic = self.bestAttemptContent.userInfo;
    NSArray<NSString *> *urlStrs = dic[kTcMedias];
#ifdef DEBUG
    NSMutableString *totalLogStr = [NSMutableString stringWithString:@"\n\n\n【标注：以下全部为日志信息，只有在debug调试状态下才会出现】"];
    NSString *urlStrsInfo = @"urlStrs为空";
    if (urlStrs.count>0) {
        urlStrsInfo = [self jsonStr:urlStrs];
    }
    [totalLogStr appendFormat:@"\n\n【======媒体资源数组信息======】\n\n%@",urlStrsInfo];
#endif
    if (urlStrs.count>0) {
        [self downloadMedias:urlStrs resuleBlock:^(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr) {
            self.bestAttemptContent.attachments = attachments;
#ifdef DEBUG
            NSArray *identifiers = [attachments valueForKeyPath:@"_identifier"];
            [totalLogStr appendFormat:@"\n\n【======媒体资源排序信息======】\n\n%@",[self jsonStr:identifiers]];
            [totalLogStr appendFormat:@"\n\n【======媒体资源下载信息======】\n\n%@====================",logStr];
            self.bestAttemptContent.body = [NSString stringWithFormat:@"%@%@",self.bestAttemptContent.body,totalLogStr];
#endif
            contentHandler(self.bestAttemptContent);
        }];
    }else{
#ifdef DEBUG
        [totalLogStr appendFormat:@"\n\n【======暂无媒体资源信息======】\n\n"];
        self.bestAttemptContent.body = [NSString stringWithFormat:@"%@%@",self.bestAttemptContent.body,totalLogStr];
#endif
        contentHandler(self.bestAttemptContent);
    }
}

- (void)serviceExtensionTimeWillExpire {
#ifdef DEBUG
    NSString *body = [NSString stringWithFormat:@"%@(debug:媒体资源下载超时)",self.bestAttemptContent.body];
    self.bestAttemptContent.body = body;
#endif
    self.contentHandler(self.bestAttemptContent);
}

#pragma mark - 根据推送过来的medias去下载相应的媒体数据

- (void)downloadMedias:(NSArray<NSString *> *)urlStrs resuleBlock:(void(^)(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr))resultBlock{
    NSMutableArray<UNNotificationAttachment *> *attachments = [NSMutableArray array];
    NSMutableString *totalLogStr = [NSMutableString string];
    NSUInteger totalCount = urlStrs.count;
    __block NSUInteger currentCount = 0;
    [urlStrs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [totalLogStr appendFormat:@"第%zd个媒体资源开始下载......-->\n\n",(idx+1)];
        [self downloadMedia:obj index:idx resuleBlock:^(UNNotificationAttachment *attachment, NSString *logStr) {
            currentCount ++;
            if (attachment) [attachments addObject:attachment];
            if (logStr.length>0) [totalLogStr appendString:logStr];
            if (totalCount == currentCount) {
                [self finishDownload:attachments logStr:totalLogStr resuleBlock:resultBlock];
            }
        }];
    }];
}

- (void)finishDownload:(NSArray<UNNotificationAttachment *> *)attachments logStr:(NSString *)logStr resuleBlock:(void(^)(NSArray<UNNotificationAttachment *> *attachments, NSString *log))resultBlock{
    NSArray<UNNotificationAttachment *> *storedAtts =
    [attachments sortedArrayUsingComparator:^NSComparisonResult(UNNotificationAttachment *obj1, UNNotificationAttachment *obj2) {
        NSNumber *num1 = @(obj1.identifier.integerValue);
        NSNumber *num2 = @(obj2.identifier.integerValue);
        return [num1 compare:num2];
    }];
    if (resultBlock) resultBlock(storedAtts,logStr);
}


- (void)downloadMedia:(NSString *)urlStr index:(NSUInteger)index resuleBlock:(void(^)(UNNotificationAttachment *attachment, NSString *logStr))resuleBlock{
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UNNotificationAttachment *attachment = nil;
        NSMutableString *logStr = [NSMutableString string];
        [logStr appendFormat:@">>>第%zd个媒体资源下载完成-开头:-->\n",(index+1)];
        if (!error) {
            [logStr appendFormat:@"下载成功-->\n"];
            NSString *filePath = [self filePath:urlStr];
            BOOL bWrite = [data writeToFile:filePath atomically:YES];
            if (bWrite) {
                [logStr appendFormat:@"写入成功-->\n"];
                NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
                if (fileUrl) {
                    [logStr appendFormat:@"fileUrl有值(%@)-->\n",fileUrl];
                    NSString *identifier = [NSString stringWithFormat:@"%zd",index];
                    NSError *attError = nil;
                    attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:fileUrl options:nil error:&attError];
                    if (!attError && attachment) {
                        [logStr appendFormat:@"attachment创建成功(attachment:%@)-->\n",attachment];
                    }else{
                        [logStr appendFormat:@"attachment创建失败(原因:%@)-->\n",attError];
                    }
                }else{
                    [logStr appendFormat:@"fileUrl无值-->\n"];
                }
            }else{
                [logStr appendFormat:@"写入失败-->\n"];
            }
        }else{
            [logStr appendFormat:@"下载失败(原因:%@)-->\n",[self jsonStr:error.userInfo]];
        }
        [logStr appendFormat:@"第%zd个媒体资源下载完成-结尾:--<\n\n",(index+1)];
        if (resuleBlock) resuleBlock(attachment,logStr);
    }];
    [task resume];
}

- (NSString *)filePath:(NSString *)urlStr {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = urlStr.lastPathComponent;
    NSRange range = [fileName rangeOfString:@"?"];
    if (range.length>0) {
        fileName = [fileName substringToIndex:range.location];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    fileName = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)jsonStr:(id)object {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!error) {
        return str;
    }else{
        return [NSString stringWithFormat:@"json转换失败-->\n【object:%@】-->\n【error:%@】",object,error];
    }
}


@end
