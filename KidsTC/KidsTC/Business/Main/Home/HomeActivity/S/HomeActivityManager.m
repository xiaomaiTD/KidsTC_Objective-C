//
//  HomeActivityManager.m
//  KidsTC
//
//  Created by zhanping on 8/9/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "HomeActivityManager.h"
#import "HomeActivityViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

NSString *const kHomeActivityUpdateNoti = @"HomeActivityUpdateNoti";

static NSString *const kHasDisplayedWebPageID = @"HasDisplayedWebPageID";

@interface HomeActivityManager ()
@end

@implementation HomeActivityManager
singleM(HomeActivityManager)

- (void)synchronize{
    TCLog(@"HomeActivity配置文件:开始请求");
    [Request startAndCallBackInChildThreadWithName:@"GET_HOME_PAGE_ACTIVITY" param:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"HomeActivity配置文件:请求成功");
        HomeActivityModel *model = [HomeActivityModel modelWithDictionary:dic];
        [self responseSuccess:model.data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[HomeActivity配置文件]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocal];
            [self update];
        }else{
            TCLog(@"[HomeActivity配置文件]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)responseSuccess:(HomeActivityDataItem *)data{
    self.data = [self validate:data]?data:nil;
    if (self.data) [self update];
}

- (void)removeLocal{
    if (self.data) self.data = nil;
}

- (void)update{
    dispatch_async(dispatch_get_main_queue(), ^{
       [NotificationCenter postNotificationName:kHomeActivityUpdateNoti object:nil];
    });
}

#pragma mark - private

- (BOOL)validate:(HomeActivityDataItem *)data{
    if (!data) {
        TCLog(@"HomeActivity:活动数据为空");
        return NO;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (data.startTime>now) {
        TCLog(@"HomeActivity:活动尚未开始");
        return NO;
    }
    if (data.endTime<now) {
        TCLog(@"HomeActivity:活动已经结束");
        return NO;
    }
    
    long hasDisplayedWebPageID = [USERDEFAULTS integerForKey:kHasDisplayedWebPageID];
    
    data.webPageCanShow = ((hasDisplayedWebPageID != data.ID) && [data.pageUrl isNotNull]);
    
    data.imageCanShow = ([data.thumbImg isNotNull] && [data.linkUrl isNotNull]);
    
    return YES;
}

#pragma mark -

- (void)checkAcitvityWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock{
    if (self.data.webPageCanShow) {
        HomeActivityViewController *controller = [[HomeActivityViewController alloc]init];
        controller.pageUrl = self.data.pageUrl;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [target presentViewController:controller animated:YES completion:nil];
        controller.resultBlock = ^void(){
            if(resultBlock) resultBlock();
            self.data.webPageCanShow = NO;
            [USERDEFAULTS setInteger:self.data.ID forKey:kHasDisplayedWebPageID];
            [USERDEFAULTS synchronize];
        };
    }else{
        if(resultBlock) resultBlock();
    }
}

@end
