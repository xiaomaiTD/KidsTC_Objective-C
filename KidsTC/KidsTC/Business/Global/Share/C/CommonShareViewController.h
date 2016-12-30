//
//  CommonShareViewController.h
//  KidsTC
//
//  Created by Altair on 11/20/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonShareObject.h"
#import "KTCShareService.h"

typedef enum : NSUInteger {
    WebViewShareCallBackTypeClickBtn = 1,//WebView点击分享按钮就回调
    WebViewShareCallBackTypeDidHasResult,//WebView真正分享成功/失败后回调
} WebViewShareCallBackType;

@interface CommonShareViewController : UIViewController

@property (nonatomic, strong, readonly) CommonShareObject *shareObject;
@property (nonatomic, readonly) KTCShareServiceType sourceType;
@property (nonatomic, assign) WebViewShareCallBackType webViewShareCallBackType;
@property (nonatomic, copy) void(^webViewCallBack)(KTCShareServiceChannel channel, BOOL success);

+ (instancetype)instanceWithShareObject:(CommonShareObject *)object;

+ (instancetype)instanceWithShareObject:(CommonShareObject *)object sourceType:(KTCShareServiceType)type;




@end
