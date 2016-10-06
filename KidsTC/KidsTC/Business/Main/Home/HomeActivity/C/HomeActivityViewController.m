//
//  HomeActivityViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/8/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeActivityViewController.h"
#import "NSDictionary+Category.h"
#import "HomeActivityManager.h"
#import "WebViewController.h"
#import "TabBarController.h"

NSString *const kActivityWebViewClosePrefix = @"hook::close_activity::";
NSString *const kActivityWebViewJumpPrefix  = @"hook::jump_activity::";

@interface HomeActivityViewController ()<UIWebViewDelegate>
@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,weak) UIButton *closeBtn;
@end

@implementation HomeActivityViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupWebView];
    
    [self setupCloseBtn];
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    self.webView = webView;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.pageUrl]];
    [self.webView loadRequest:request];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateWebPage];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)animateWebPage{
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.webView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.webView.transform = CGAffineTransformIdentity;
                self.closeBtn.hidden = NO;
            }];
        }];
    }];
}

- (void)close{
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 0;
        self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
        if (self.resultBlock) self.resultBlock();
        [self back];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self close];
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
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = YES;
    self.closeBtn = btn;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr =  request.URL.absoluteString;
    TCLog(@"HomeActivity-urlStr-:%@",urlStr);
    if ([urlStr hasPrefix:kActivityWebViewClosePrefix]) {
        [self close];
        return NO;
    } else if ([urlStr hasPrefix:kActivityWebViewJumpPrefix]) {
        [self close];
        NSString *linkUrl = @"";
        NSString *substr = [urlStr substringFromIndex:[kActivityWebViewJumpPrefix length]];
        if (substr.length > 0) {
            NSRange range = [substr rangeOfString:@"url="];
            if (range.length > 0) {
                NSString *linkUrlStr = [substr substringFromIndex:(range.location+range.length)];
                if (linkUrlStr.length > 0) linkUrl = linkUrlStr;
            }
        }
        if (linkUrl.length == 0) linkUrl = [HomeActivityManager shareHomeActivityManager].data.linkUrl;
        if (linkUrl.length != 0) {
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.urlString = linkUrl;
            UINavigationController *navi = (UINavigationController *)[TabBarController shareTabBarController].selectedViewController;
            [navi pushViewController:webVC animated:YES];
        }
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{}
- (void)webViewDidFinishLoad:(UIWebView *)webView{}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{}

- (void)dealloc{
    self.webView.scrollView.delegate = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

@end
