//
//  WelcomeManager.h
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"

extern NSString *const kWelcomeViewControllerFinishShow;

@interface WelcomeManager : NSObject
singleH(WelcomeManager)

/**
 *  检查是否需要展示引导页
 *
 *  @param target      当前控制器
 *  @param resuleBlock 展示完引导页面后的回调
 */
- (void)checkWelcomeWithWindow:(UIWindow *)window resultBlock:(void(^)())resultBlock;
@end
