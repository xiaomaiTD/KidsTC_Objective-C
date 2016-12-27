//
//  WolesaleProductDetailWebCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailWebCell.h"

@interface WolesaleProductDetailWebCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WolesaleProductDetailWebCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.scrollsToTop = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    WholesaleProductDetailBase *base = data.fightGroupBase;
    if (!base.webViewHasLoad) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:base.detailUrl]];
        [self.webView loadRequest:request];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    size.height = self.webView.scrollView.contentSize.height;
    return size;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.data.fightGroupBase.webViewHasLoad = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.data.fightGroupBase.webViewHasLoad = YES;
}

@end
