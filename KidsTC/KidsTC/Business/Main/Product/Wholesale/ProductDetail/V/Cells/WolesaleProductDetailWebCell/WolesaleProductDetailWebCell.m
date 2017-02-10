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
@property (nonatomic, assign) BOOL webViewHasLoad;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.webView.scrollView.contentSize.height != self.frame.size.height) {
            [self webLoadFinish];
        }
    });
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    if (self.webView.isLoading || self.webViewHasLoad) return;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data.fightGroupBase.detailUrl]];
    [self.webView loadRequest:request];
    self.webViewHasLoad = YES;
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.webViewHasLoad) {
        size.height = self.webView.scrollView.contentSize.height;
    }else{
        size.height = SCREEN_HEIGHT*1.5;
    }
    return size;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self webLoadFinish];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self webLoadFinish];
}
#pragma mark - UIWebViewDelegate helper
- (void)webLoadFinish {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeWebLoadFinish value:nil];
    }
}

@end
