//
//  FlashBuyProductDetailWebCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailWebCell.h"

@interface FlashBuyProductDetailWebCell ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FlashBuyProductDetailWebCell

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

- (CGSize)sizeThatFits:(CGSize)size {
    
    [self layoutIfNeeded];
    CGFloat web_h = self.webView.scrollView.contentSize.height;
    if (self.data.webViewHasLoad) {
        return CGSizeMake(size.width, web_h);
    }else{
        return CGSizeMake(size.width, SCREEN_HEIGHT*1.5);
    }
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    if (!self.data.webViewHasLoad) {
        NSString *rulStr = [data.detailUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:rulStr]];
        [self.webView loadRequest:request];
    }
    [self layoutIfNeeded];
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
    self.data.webViewHasLoad = YES;
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailBaseCell:actionType:vlaue:)]) {
        [self.delegate flashBuyProductDetailBaseCell:self actionType:FlashBuyProductDetailBaseCellActionTypeWebLoadFinish vlaue:nil];
    }
}


@end
