//
//  ProductDetailTwoColumnCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnCell.h"

@interface ProductDetailTwoColumnCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ProductDetailTwoColumnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    NSString *rulStr = data.detailUrl;
    rulStr = [rulStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:rulStr]];
    [self.webView loadRequest:request];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self layoutIfNeeded];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self layoutIfNeeded];
}

@end
