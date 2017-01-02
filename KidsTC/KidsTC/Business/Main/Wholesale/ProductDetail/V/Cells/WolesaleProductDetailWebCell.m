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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.webView.scrollView.contentSize.height != self.frame.size.height) {
            [self webLoadFinish];
        }
    });
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
    WholesaleProductDetailBase *base = self.data.fightGroupBase;
    if (base.webViewHasLoad) {
        size.height = self.webView.scrollView.contentSize.height;
    }else{
        size.height = SCREEN_HEIGHT;
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
    self.data.fightGroupBase.webViewHasLoad = YES;
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeWebLoadFinish value:nil];
    }
}

@end
