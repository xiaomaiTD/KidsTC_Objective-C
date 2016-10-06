//
//  HomeRefreshManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshManager.h"
#import "NSString+Category.h"
#import "HomeRefreshViewController.h"

NSString *const kHomeRefreshNewDataNoti = @"HomeRefreshNewDataNoti";

static NSString *const HomeRefreshFileName = @"HomeRefresh";

@implementation HomeRefreshManager
singleM(HomeActivityManager)

- (HomeRefreshModel *)model{
    /*
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(HomeRefreshFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    */
    if (_model) {
        if (![self validate:_model.data]) {
            [self removeLocal];
        }
    }
    return _model;
}

- (void)synchronize {
    [Request startAndCallBackInChildThreadWithName:@"DROP_DOWN_ACTIVITY_GET" param:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        HomeRefreshModel *model = [HomeRefreshModel modelWithDictionary:dic];
        [self synchronizeSuccess:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self synchronizeFailure:error];
    }];
}

- (void)synchronizeSuccess:(HomeRefreshModel *)model {
    if ([self validate:model.data]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(HomeRefreshFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[HomeRefresh]:写入成功");
        }else{
            TCLog(@"[HomeRefresh]:写入失败");
        }
        self.model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [NotificationCenter postNotificationName:kHomeRefreshNewDataNoti object:nil];
        });
    }else{
        
        [self removeLocal];
    }
}

- (BOOL)validate:(HomeRefreshData *)data{
    if (!data) {
        TCLog(@"[HomeRefresh]:活动数据为空");
        return NO;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (data.startTime>now) {
        TCLog(@"[HomeRefresh]:活动尚未开始");
        return NO;
    }
    if (data.endTime<now) {
        TCLog(@"[HomeRefresh]:活动已经结束");
        return NO;
    }
    if (![data.imgUrl isNotNull]) {
        TCLog(@"[HomeRefresh]:活动配置图片为空");
        return NO;
    }
    if (![data.pageUrl isNotNull]) {
        TCLog(@"[HomeRefresh]:活动展示页面为空");
        return NO;
    }
    return YES;
}

- (void)synchronizeFailure:(NSError *)error {
    if (error.code == -2001) {
        TCLog(@"[HomeRefresh]:请求失败--移除本地--%@",[NSThread currentThread]);
        [self removeLocal];
    }else{
        TCLog(@"[HomeRefresh]:请求失败--不作处理--%@",[NSThread currentThread]);
    }
}

- (void)removeLocal {
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(HomeRefreshFileName) error:nil];
    self.model = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [NotificationCenter postNotificationName:kHomeRefreshNewDataNoti object:nil];
    });
}

#pragma mark -

- (void)checkHomeRefreshPageWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock{
    NSString *pageUrl = self.model.data.pageUrl;
    if ([pageUrl isNotNull]) {
        HomeRefreshViewController *controller = [[HomeRefreshViewController alloc]init];
        controller.urlString = self.model.data.pageUrl;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [target presentViewController:controller animated:NO completion:nil];
        controller.resultBlock = ^void(){
            if(resultBlock) resultBlock();
        };
    }else{
        if(resultBlock) resultBlock();
    }
}

@end
