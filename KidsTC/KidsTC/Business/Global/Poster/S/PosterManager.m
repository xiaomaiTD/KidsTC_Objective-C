//
//  PosterManager.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "PosterManager.h"

NSString *const PosterModelFileName = @"PosterModel";

NSString *const kPosterViewControllerFinishShow = @"PosterViewControllerFinishShow";

@interface PosterManager ()
@property (nonatomic, strong) PosterModel *model;
@end

@implementation PosterManager
singleM(PosterManager)

- (PosterModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(PosterModelFileName)];
        if (data) {
            _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        [self validate];
    }
    return _model;
}

#pragma mark - synchronize

- (void)synchronize{
    NSString *md5 = self.model.md5.length>0?self.model.md5:@"";
    TCLog(@"[广告-配置文件]:开始请求，本地md5：%@",md5);
    NSDictionary *param = @{@"key":md5};
    [Request startAndCallBackInChildThreadWithName:@"GET_LAUNCH" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[广告-配置文件]:请求成功--%@",[NSThread currentThread]);
        PosterModel *model = [PosterModel modelWithDictionary:dic];
        if (![self validateWithModel:model]) return;
        [self responseSuccess:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[广告-配置文件]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[广告-配置文件]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)responseSuccess:(PosterModel *)model{
    NSArray<PosterAdsItem *> *ads = model.data.ads;
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    [ads enumerateObjectsUsingBlock:^(PosterAdsItem *obj, NSUInteger idx, BOOL *stop) {
        [self downloadImgWith:obj index:idx group:group queue:queue];
    }];
    dispatch_group_notify(group, queue, ^{
        __block BOOL allImghasDownloaded = YES;
        [ads enumerateObjectsUsingBlock:^(PosterAdsItem *obj, NSUInteger idx, BOOL *stop) {
            if (!obj.imageData) {
                allImghasDownloaded = NO;
                *stop = YES;
            }
        }];
        if (allImghasDownloaded) {
            TCLog(@"广告-所有图片下载最终结果-全部成功");
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            BOOL bWtire = [data writeToFile:FILE_CACHE_PATH(PosterModelFileName) atomically:YES];
            if (bWtire) {
                TCLog(@"广告-文件配置模型写入成功--%@",[NSThread currentThread]);
                self.model = model;
                self.hasShow = NO;
            }else{
                TCLog(@"广告-文件配置模型写入失败--%@",[NSThread currentThread]);
            }
        }else{
            TCLog(@"广告-所有图片下载最终结果-没有全部成功");
        }
    });
}

- (void)downloadImgWith:(PosterAdsItem *)item
                  index:(NSUInteger)index
                  group:(dispatch_group_t)group
                  queue:(dispatch_queue_t)queue
{
    
    dispatch_group_async(group, queue, ^{
        TCLog(@"广告-开始下载第%zd张图片,路径:%@",index,item.img);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.img]];
        UIImage *image = [UIImage imageWithData:data];
        if (data && image) {
            TCLog(@"广告-第%zd张图片下载成功,路径:%@",index,item.img);
            item.imageData = data;
        }else{
            TCLog(@"广告-第%zd张图片下载失败,路径:%@",index,item.img);
        }
    });
}

- (void)removeLocalTheme{
    if (_model) {
        NSError *err = nil;
        [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(PosterModelFileName) error:&err];
        if (!err) {
            TCLog(@"广告-移除本地成功");
            _model = nil;
        }else{
            TCLog(@"广告-移除本地失败");
        }
    }
}

- (BOOL)validate{
    return [self validateWithModel:_model];
}

- (BOOL)validateWithModel:(PosterModel *)model{
    
    if (!model) {
        TCLog(@"广告-校验-model为空");
        [self removeLocalTheme];
        return NO;
    };
    
    if (!model.data) {
        TCLog(@"广告-校验-model.data为空");
        [self removeLocalTheme];
        return NO;
    }
    
    if (model.data.ads.count==0) {
        TCLog(@"广告-校验-数据无效");
        [self removeLocalTheme];
        return NO;
    }
    
    NSTimeInterval timeInterval = model.data.expireTime;
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    if (nowTimeInterval > timeInterval){
        TCLog(@"广告-校验-已经过期");
        [self removeLocalTheme];
        return NO;
    }
    
    return YES;
}

#pragma mark - checkPoster

- (void)checkPosterWithWindow:(UIWindow *)window resultBlock:(void(^)())resultBlock{
    
    if (!self.hasShow && self.validate) {
        PosterViewController *controller = [[PosterViewController alloc]init];
        controller.ads = _model.data.ads;
        window.hidden = NO;
        window.rootViewController = controller;
        [window makeKeyAndVisible];
        controller.resultBlock = ^void(){
            [UIView animateWithDuration:1.5 animations:^{
                window.alpha = 0;
                window.transform = CGAffineTransformMakeScale(1.5, 1.5);
            } completion:^(BOOL finished) {
                window.hidden = YES;
                window.alpha = 1;
                window.transform = CGAffineTransformIdentity;
                window.rootViewController = nil;
               [self finishShow:resultBlock];
            }];
        };
    }else{
        [UIView animateWithDuration:1.5 animations:^{
            window.alpha = 0;
        } completion:^(BOOL finished) {
            window.hidden = YES;
            window.alpha = 1;
            window.rootViewController = nil;
            [self finishShow:resultBlock];
        }];
    }
}

- (void)finishShow:(void(^)())resultBlock{
    if(resultBlock) resultBlock();
    self.hasShow = YES;
    [NotificationCenter postNotificationName:kPosterViewControllerFinishShow object:nil];
}

@end
