//
//  TCStoreDetailWebCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailWebCell.h"

@interface TCStoreDetailWebCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) BOOL webViewHasLoad;
@end

@implementation TCStoreDetailWebCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.scrollsToTop = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.delegate = self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self layoutIfNeeded];
    if (self.webViewHasLoad) {
        size.height = self.webView.scrollView.contentSize.height;
    }else{
        size.height = SCREEN_HEIGHT*1.5;
    }
    return size;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    if (!self.webView.isLoading && !self.webViewHasLoad) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.data.storeBase.detailUrl]];
        [self.webView loadRequest:request];
        self.webViewHasLoad = YES;
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self webViewFinishLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self webViewFinishLoad];
}

#pragma mark - UIWebViewDelegate helper

- (void)webViewFinishLoad {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeWebLoadFinish value:nil];
    }
}

@end
