//
//  HomeRefreshManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshManager.h"
#import "NSString+Category.h"


NSString *const kHomeRefreshNewDataNoti = @"HomeRefreshNewDataNoti";
static NSString *const HomeRefreshFileName = @"HomeRefresh";
static NSString *const kHomeRefreshGuide = @"HomeRefreshGuide";

@interface HomeRefreshManager ()
@property (nonatomic, strong) HomeRefreshGuideView *guideView;
@end

@implementation HomeRefreshManager
singleM(HomeRefreshManager)

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
        self.hasSuprise = YES;
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
    self.hasSuprise = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [NotificationCenter postNotificationName:kHomeRefreshNewDataNoti object:nil];
    });
}

#pragma mark -

- (void)checkHomeRefreshPageWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock{
    
    if (_hasSuprise) {
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

- (void)checkHomeRefreshGuideWithTarget:(UIViewController *)target top:(CGFloat)top resultBlock:(void(^)())resultBlock {
    BOOL hasShow = [USERDEFAULTS boolForKey:kHomeRefreshGuide];
    
    if(!hasShow && _hasSuprise) {//
        if (!_guideView) {
            _guideView = [[NSBundle mainBundle] loadNibNamed:@"HomeRefreshGuideView" owner:self options:nil].firstObject;
        }
        _guideView.frame = target.view.bounds;
        _guideView.top = top;
        [target.view addSubview:_guideView];
        _guideView.resultBlock = ^void(){
            if(resultBlock) resultBlock();
            [USERDEFAULTS setValue:@(YES) forKey:kHomeRefreshGuide];
            [USERDEFAULTS synchronize];
        };
    }else {
        if (resultBlock) resultBlock();
    }
}

@end
