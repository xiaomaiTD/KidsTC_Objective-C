//
//  ComposeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeButton.h"
#import "User.h"
#import "ArticleWriteViewController.h"
#import "WebViewController.h"
#import "TabBarController.h"
#import "NavigationController.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"

static CGFloat const kAnimationDuration = 0.4;
static CGFloat const kSleepDuration = 0.2;

static CGFloat const kMargin_b = 100;
static CGFloat const kBtn_w = 80;
static CGFloat const kBtn_h = 80;

@interface ComposeViewController ()
@property (nonatomic, strong) ComposeButton *btnCompose;
@property (nonatomic, strong) ComposeButton *btnSign;
@property (nonatomic, strong) CAGradientLayer *layer;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupLayer];
    
    [self setupBtns];
    
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide:nil];
}

- (void)setupLayer {

    UIColor *middle_color = [UIColor whiteColor];
    UIColor *start_end_color = [UIColor colorWithWhite:1 alpha:0.0];
    NSArray *colors = @[(id)start_end_color.CGColor,(id)middle_color.CGColor, (id)start_end_color.CGColor];
    NSArray *locations = @[@(0.0), @(0.8), @(0.9)];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.colors = colors;
    layer.locations = locations;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    CGFloat layer_h = 200;
    layer.frame = CGRectMake(0, SCREEN_HEIGHT - layer_h - 49, SCREEN_WIDTH, layer_h);
    [self.view.layer addSublayer:layer];
    layer.opacity = 0.0;
    self.layer = layer;
    
}

- (void)setupBtns {
    
    ComposeData *data = self.model.data.data;
    
    _btnCompose = [ComposeButton btn:ComposeButtonTypeCompose data:data.leftTopBtn];
    [_btnCompose addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCompose];
    
    _btnSign = [ComposeButton btn:ComposeButtonTypeSign data:data.rightTopBtn];
    [_btnSign addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSign];
}

- (void)show {
    
    CGFloat btn_y = SCREEN_HEIGHT - kBtn_h - kMargin_b;
    CGFloat margin_h = (SCREEN_WIDTH - kBtn_w * 2) / (2 + 1);
    
    CGFloat btn_x_0 = margin_h + (margin_h + kBtn_w) * 0;
    CGRect btn_f_0 = CGRectMake(btn_x_0, btn_y, kBtn_w, kBtn_h);
    
    CGFloat btn_x_1 = margin_h + (margin_h + kBtn_w) * 1;
    CGRect btn_f_1 = CGRectMake(btn_x_1, btn_y, kBtn_w, kBtn_h);
    
    CGRect frame = CGRectMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT, 0, 0);
    CGFloat alpha_begin = 0.0;
    CGFloat alpha_end = 1.0;
    
    self.btnCompose.frame = frame;
    self.btnSign.frame = frame;
    self.btnCompose.alpha = alpha_begin;
    self.btnSign.alpha = alpha_begin;
    
    self.layer.opacity = alpha_begin;
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration+kSleepDuration];
    self.layer.opacity = alpha_end;
    [CATransaction commit];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.btnCompose.frame = btn_f_0;
        self.btnCompose.alpha = alpha_end;
    } completion:^(BOOL finished) {
        [self scale:self.btnCompose];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kSleepDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.btnSign.frame = btn_f_1;
            self.btnSign.alpha = alpha_end;
        } completion:^(BOOL finished) {
            [self scale:self.btnSign];
        }];
    });
}

- (void)scale:(UIView *)view {
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            view.transform = CGAffineTransformMakeScale(1.1, 1.1);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 animations:^{
//                view.transform = CGAffineTransformMakeScale(1.2, 1.2);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.2 animations:^{
//                    view.transform = CGAffineTransformIdentity;
//                }];
//            }];
//        }];
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)hide:(void(^)())completeBlock {
    
    CGFloat btn_y = SCREEN_HEIGHT - kBtn_h - kMargin_b;
    CGFloat margin_h = (SCREEN_WIDTH - kBtn_w * 2) / (2 + 1);
    
    CGFloat btn_x_0 = margin_h + (margin_h + kBtn_w) * 0;
    CGRect btn_f_0 = CGRectMake(btn_x_0, btn_y, kBtn_w, kBtn_h);
    
    CGFloat btn_x_1 = margin_h + (margin_h + kBtn_w) * 1;
    CGRect btn_f_1 = CGRectMake(btn_x_1, btn_y, kBtn_w, kBtn_h);
    
    CGRect frame = CGRectMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT, 0, 0);
    CGFloat alpha_begin = 1.0;
    CGFloat alpha_end = 0.0;
    
    self.btnCompose.frame = btn_f_0;
    self.btnSign.frame = btn_f_1;
    self.btnCompose.alpha = alpha_begin;
    self.btnSign.alpha = alpha_begin;
    
    self.layer.opacity = alpha_begin;
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration+kSleepDuration];
    self.layer.opacity = alpha_end;
    [CATransaction commit];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.btnSign.frame = frame;
        self.btnSign.alpha = alpha_end;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kSleepDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.btnCompose.frame = frame;
            self.btnCompose.alpha = alpha_end;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                if (completeBlock) completeBlock();
            }];
        }];
    });
    
}


- (void)action:(ComposeButton *)btn {
    [self hide:^{
        ComposeData *data = self.model.data.data;
        NavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
        UIViewController *target = navi.topViewController;
        
        switch (btn.type) {
            case ComposeButtonTypeCompose:
            {
                if (data.articleClasses.count>0) {
                    [[User shareUser] checkLoginWithTarget:target resultBlock:^(NSString *uid, NSError *error) {
                        ArticleWriteViewController *controller = [[ArticleWriteViewController alloc] init];
                        controller.articleClasses = data.articleClasses;
                        NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
                        [target presentViewController:navi animated:YES completion:nil];
                    }];
                    [BuryPointManager trackEvent:@"event_skip_home_artical" actionId:20107 params:nil];
                }else{
                    [[iToast makeText:@"暂不支持投稿哟~"] show];
                }
            }
                break;
            case ComposeButtonTypeSign:
            {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = data.signInPageUrl;
                [navi pushViewController:controller animated:YES];
                [BuryPointManager trackEvent:@"event_skip_home_sign" actionId:20108 params:nil];
            }
                break;
        }
    }];
}



@end
