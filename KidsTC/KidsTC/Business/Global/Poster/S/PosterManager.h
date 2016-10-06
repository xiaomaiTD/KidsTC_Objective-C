//
//  PosterManager.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "PosterModel.h"
#import "PosterViewController.h"

extern NSString *const kPosterViewControllerFinishShow;

@interface PosterManager : NSObject
singleH(PosterManager)
@property (nonatomic, assign) BOOL hasShow;
- (void)synchronize;
/**
 *  检查是否需要展示广告
 *
 *  @param target      当前控制器
 *  @param resuleBlock 展示完广告页面后的回调
 */
- (void)checkPosterWithWindow:(UIWindow *)window resultBlock:(void(^)())resultBlock;
@end
