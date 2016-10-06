//
//  WebViewController.h
//  KidsTC
//
//  Created by zhanping on 8/29/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

@interface WebViewController : ViewController
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, strong) NSString *urlString;
- (void)reload;
@end
