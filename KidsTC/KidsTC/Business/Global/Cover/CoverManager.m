//
//  CoverManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CoverManager.h"

#import "WelcomeManager.h"
#import "PosterManager.h"

@interface CoverManager ()
@property (nonatomic, strong) UIWindow *showWindow;
@end

@implementation CoverManager
singleM(CoverManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        _showWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _showWindow.backgroundColor = [UIColor whiteColor];
        _showWindow.windowLevel = UIWindowLevelAlert + 1;
    }
    return self;
}

- (void)showWelcome:(void(^)())resultBlock{
    [[WelcomeManager shareWelcomeManager] checkWelcomeWithWindow:_showWindow resultBlock:^{
        TCLog(@"CoverManager-showWelcome-欢迎页处理完毕");
        [[User shareUser] checkRoleWithWindow:_showWindow resultBlock:^{
            TCLog(@"CoverManager-showWelcome-角色选择页处理完毕");
            [[CoverManager shareCoverManager] showPoster:^{
                if(resultBlock) resultBlock();
            }];
        }];
    }];
}

- (void)showPoster:(void(^)())resultBlock{
    [[PosterManager sharePosterManager] checkPosterWithWindow:self.showWindow resultBlock:^{
        TCLog(@"CoverManager-showPoster-广告页处理完毕");
        if(resultBlock) resultBlock();
    }];
}

@end
