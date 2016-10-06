//
//  WelcomeManager.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelcomeManager.h"
#import "WelcomeViewController.h"

static NSString *const kWelcomeHasShow = @"WelcomeHasShow";

NSString *const kWelcomeViewControllerFinishShow = @"WelcomeViewControllerFinishShow";

@interface WelcomeManager ()
@property (nonatomic, strong) NSArray<UIImage *> *images;
@end

@implementation WelcomeManager
singleM(WelcomeManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        if (!self.hasShow) {
            CGFloat scale = [UIScreen mainScreen].scale;
            NSUInteger px_w = (NSUInteger)SCREEN_WIDTH * scale;
            NSUInteger px_h = (NSUInteger)SCREEN_HEIGHT * scale;
            NSMutableArray *ary = [NSMutableArray array];
            NSUInteger pageCount = 4;
            for (NSUInteger i = 0; i<pageCount; i++) {
                NSString *imageName = [NSString stringWithFormat:@"welcome_page%zd_%zd_%zd", i+1, px_w,px_h];
                UIImage *image = [UIImage imageNamed:imageName];
                if (!image) {
                    image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome_page%zd_1242_2208",i+1]];
                }
                if (image) [ary addObject:image];
            }
            self.images = ary;
        }
    }
    return self;
}

- (void)checkWelcomeWithWindow:(UIWindow *)window resultBlock:(void(^)())resultBlock{
    if (!self.hasShow && self.images.count>0) {
        WelcomeViewController *controller = [[WelcomeViewController alloc]init];
        controller.images = self.images;
        window.hidden = NO;
        window.rootViewController = controller;
        [window makeKeyAndVisible];
        WeakSelf(controller)
        controller.resultBlock = ^void(){
            StrongSelf(controller)
            [UIView animateWithDuration:0.5 animations:^{
                controller.view.alpha = 0;
            } completion:^(BOOL finished) {
                [self finishShow:resultBlock];
            }];
        };
    }else{
        [self finishShow:resultBlock];
    }
}

- (BOOL)hasShow{
    return [USERDEFAULTS boolForKey:kWelcomeHasShow];
}

- (void)finishShow:(void(^)())resultBlock{
    if(resultBlock) resultBlock();
    [USERDEFAULTS setBool:YES forKey:kWelcomeHasShow];
    [USERDEFAULTS synchronize];
    [NotificationCenter postNotificationName:kWelcomeViewControllerFinishShow object:nil];
}

@end
