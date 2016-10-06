//
//  AppVersionManager.m
//  KidsTC
//
//  Created by zhanping on 8/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AppVersionManager.h"
#import "AppVersionModel.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "AppVersionViewController.h"

typedef enum : NSUInteger {
    UpdateTypePresent=1,
    UpdateTypeAlert,
} UpdateType;

static NSString *const kAppVersionUpdateTime = @"AppVersionUpdateTime";
static NSTimeInterval const updateTimeInterval = 60 * 60 * 24 * 2;

@implementation AppVersionManager
singleM(AppVersionManager)

- (void)checkRemote{
    [Request checkVersionWithName:@"APP_UPDATE_VERSION" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self checkRemoteSuccess:[AppVersionModel modelWithDictionary:dic]];
    } failure:nil];
}

- (void)checkRemoteSuccess:(AppVersionModel *)model {
    AppVersionData *data = model.data;
    if (data.isUpdate && [self isOverLastUpdateTime]) {
        [self downloadImgWithModel:model resultBlock:^(UIImage *bgImg, UIImage *btnImg, UpdateType type) {
            data.bgImg = bgImg;
            data.btnImg = btnImg;
            [self downloadImgFinished:data showType:type];
        }];
    }
}

- (void)downloadImgWithModel:(AppVersionModel *)model resultBlock:(void(^)(UIImage *bgImg, UIImage *btnImg, UpdateType type))resultBlock {
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    __block UIImage *bgImg = nil;
    __block UIImage *btnImg = nil;
    dispatch_group_async(group, queue, ^{
        NSData *bgImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.data.bgImgUrl]];
        bgImg = [UIImage imageWithData:bgImgData];
    });
    dispatch_group_async(group, queue, ^{
        NSData *btnImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.data.btnImgUrl]];
        btnImg = [UIImage imageWithData:btnImgData];
    });
    dispatch_group_notify(group, queue, ^{
        UpdateType type;
        if (bgImg && btnImg){
            TCLog(@"AppVersion两张图片下载成功-使用下载图片：\nfImg:%@\nsImg:%@",bgImg,btnImg);
            type = UpdateTypePresent;
        }else{
            bgImg = [UIImage imageNamed:@"appVersion_bgImg"];
            btnImg = [UIImage imageNamed:@"appVersion_btnImg"];
            TCLog(@"AppVersion两张图片下载失败-使用本地图片：\nfImg:%@\nsImg:%@",bgImg,btnImg);
            type = UpdateTypeAlert;
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultBlock) {
                resultBlock(bgImg,btnImg,type);
            }
        });
    });
}

- (void)downloadImgFinished:(AppVersionData *)data showType:(UpdateType)type {
    UIViewController *controller = [TabBarController shareTabBarController].selectedViewController;
    switch (type) {
        case UpdateTypePresent:
        {
            [self presentWtihTarget:controller data:data];
        }
            break;
        case UpdateTypeAlert:
        {
            [self alertWtihTarget:controller data:data];
        }
            break;
    }
}


- (void)presentWtihTarget:(UIViewController *)target data:(AppVersionData *)data {
    
    AppVersionViewController *controller = [[AppVersionViewController alloc] init];
    controller.data = data;
    controller.updateBlock = ^void (){
        [self updateAction];
    };
    controller.cancleBlock = ^void (){
        [self cancleAction:data.isForceUpdate];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [target presentViewController:controller animated:NO completion:nil];
}

- (void)alertWtihTarget:(UIViewController *)target data:(AppVersionData *)data {
    
    NSString *title = [NSString stringWithFormat:@"发现新版本 %@",data.appNewVersion];
    NSString *message = data.desc;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSString *leftTitle = data.isForceUpdate?@"退出":@"稍后再说";
    UIAlertAction *left = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancleAction:data.isForceUpdate];
    }];
    UIAlertAction *right = [UIAlertAction actionWithTitle:@"立即去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateAction];
    }];
    [alert addAction:left];
    [alert addAction:right];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)updateAction{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_APP_STORE_UPDATE]];
}

- (void)cancleAction:(BOOL)exit {
    if (exit) {
        [self exitApplication];
    }else{
        [USERDEFAULTS setObject:[NSDate date] forKey:kAppVersionUpdateTime];
        [USERDEFAULTS synchronize];
    }
}

- (BOOL)isOverLastUpdateTime{
    NSDate *lastUpdateTime = [USERDEFAULTS objectForKey:kAppVersionUpdateTime];
    if (lastUpdateTime == nil)return YES;
    return [[NSDate date] timeIntervalSinceDate:lastUpdateTime] > updateTimeInterval;
}

- (void)exitApplication{
    UIWindow *window = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    [UIView animateWithDuration:0.5 animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

@end
