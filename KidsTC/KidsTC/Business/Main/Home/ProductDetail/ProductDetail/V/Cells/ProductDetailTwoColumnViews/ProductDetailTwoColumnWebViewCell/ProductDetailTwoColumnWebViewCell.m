//
//  ProductDetailTwoColumnWebViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnWebViewCell.h"
#import "NSArray+Category.h"

@interface ProductDetailTwoColumnWebViewCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *openDetailView;
@property (weak, nonatomic) IBOutlet UIButton *openDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *openDetailL;

@end

@implementation ProductDetailTwoColumnWebViewCell

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
    
    self.openDetailL.textColor = PRODUCT_DETAIL_BLUE;
}

- (IBAction)openWebView:(UIButton *)sender {
    if (self.data.webViewHasOpen) return;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeOpenWebView value:nil];
    }
    self.data.webViewHasOpen = YES;
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self layoutIfNeeded];
    CGFloat web_h = self.webView.scrollView.contentSize.height;
    if (self.data.webViewHasOpen) {
        return CGSizeMake(size.width, web_h);
    }else{
        if (self.data.webViewHasLoad) {
            if (web_h<=SCREEN_HEIGHT*1.5) {
                if (web_h<44) web_h = 44;
                return CGSizeMake(size.width, web_h);
            }else{
                CGFloat h = web_h*0.5;
                if (h<=SCREEN_HEIGHT*1.5) {
                    return CGSizeMake(size.width, SCREEN_HEIGHT*1.5);
                }else{
                    return CGSizeMake(size.width, h);
                }
            }
        }else{
            return CGSizeMake(size.width, SCREEN_HEIGHT*1.5);
        }
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.openDetailView.hidden = self.data.webViewHasOpen;
    
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
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeWebViewFinishLoad value:nil];
    }
}


@end
