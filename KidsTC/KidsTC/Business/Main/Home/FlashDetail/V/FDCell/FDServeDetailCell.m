//
//  FDServeDetailCell.m
//  KidsTC
//
//  Created by zhanping on 5/19/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDServeDetailCell.h"

@interface FDServeDetailCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FDServeDetailCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    //修改webView的背景色
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#EFEFF4'"];
}
-(void)setUrlString:(NSString *)urlString{
    if (!_urlString) {
        _urlString = urlString;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.webView.isLoading) {
                [self getWebViewHight];
            }
        });
    }
}

- (void)setDidFinishLoadingBlock:(void (^)(CGFloat))didFinishLoadingBlock{
    if (!_didFinishLoadingBlock) {
        _didFinishLoadingBlock = didFinishLoadingBlock;
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self getWebViewHight];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self getWebViewHight];
}

- (void)getWebViewHight{
    
    BOOL isHttpRequest = [self.webView.request.URL.absoluteString hasPrefix:@"http:"];
    if (self.didFinishLoadingBlock && isHttpRequest) {
        CGFloat hight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        CGRect frame = self.webView.frame;
        frame.size.height = hight;
        self.webView.frame = frame;
        self.didFinishLoadingBlock(hight);
    }
}

@end
