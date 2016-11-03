//
//  ComposeManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeManager.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ComposeViewController.h"
#import "TabBarController.h"

static NSString *const ComposeFileName = @"Compose";

@interface ComposeManager ()

@end

@implementation ComposeManager
singleM(ComposeManager)

- (ComposeModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(ComposeFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}

- (void)synchronize {
    NSString *md5 = @"";
    NSDictionary *param = @{@"populationType":[User shareUser].role.roleIdentifierString,
                            @"md5":md5};
    [Request startAndCallBackInChildThreadWithName:@"GET_WIRELESS_HOME_MIDDLE_BTN" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ComposeModel *model = [ComposeModel modelWithDictionary:dic];
        if (![self valid:model]) return;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(ComposeFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[Compose]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[Compose]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[Compose]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[Compose]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(ComposeFileName) error:nil];
    self.model = nil;
}

- (BOOL)valid:(ComposeModel *)model {
    
    ComposeData *data = model.data.data;
    
    if (data.articleClasses.count<1) {
        TCLog(@"[Compose]:分类信息为空，不展示！");
        return false;
    }
    if (![data.signInPageUrl isNotNull]) {
        TCLog(@"[Compose]:萝卜签到地址为空，不展示！");
        return false;
    }
    if (!data.isShow) {
        TCLog(@"[Compose]:isShow为false，不展示！且移除本地~");
        [self removeLocalTheme];
        return false;
    }
    return true;
}

- (void)showCompose:(void(^)())resultBlock{
    UIViewController *target = [TabBarController shareTabBarController];
    ComposeViewController *controller = [[ComposeViewController alloc] init];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.model = self.model;
    controller.resultBlock = resultBlock;
    [target presentViewController:controller animated:NO completion:nil];
}


@end
