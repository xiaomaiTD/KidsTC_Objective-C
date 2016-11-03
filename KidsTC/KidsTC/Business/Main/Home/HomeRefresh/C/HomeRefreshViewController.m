//
//  HomeRefreshViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshViewController.h"
@interface HomeRefreshViewController()
@property (nonatomic,weak) UIButton *closeBtn;
@end

@implementation HomeRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.bounces = NO;
    [self setupCloseBtn];
}

- (void)setupCloseBtn {
    CGFloat y = 30;
    CGFloat size = 30;
    CGFloat x = SCREEN_WIDTH - size - 12;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, size, size)];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = size*0.5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setBackgroundImage:[UIImage imageNamed:@"health_run_icon_close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = YES;
    self.closeBtn = btn;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateWebPage];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)animateWebPage{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        self.closeBtn.hidden = NO;
    }];
}

- (void)back{
    /*
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 0;
        self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        //self.view.hidden = YES;
        self.view.transform = CGAffineTransformIdentity;
        
    }];*/
    if (self.resultBlock) self.resultBlock();
    [super back];
}



@end
