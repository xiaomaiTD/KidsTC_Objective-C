//
//  SchemeManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SchemeManager.h"

#import "WeChatManager.h"
#import "AlipayManager.h"
#import "TencentManager.h"
#import "WeiboManager.h"

#import "NSDictionary+Category.h"
#import "SegueMaster.h"
#import "TabBarController.h"

@implementation SchemeManager

+ (BOOL)openUrl:(NSURL *)url {
    if ([url.scheme isEqualToString:kAlipayFromScheme]){        //支付宝
        return [[AlipayManager sharedManager] handleOpenUrl:url];
    }else if ([url.scheme isEqualToString:kWeChatUrlScheme]){   //微信
        return [[WeChatManager sharedManager] handleOpenURL:url];
    }else if ([url.scheme isEqualToString:kTencentUrlScheme]){  //QQ
        return [[TencentManager sharedManager] handleOpenURL:url];
    } else if ([url.scheme isEqualToString:kWeiboUrlScheme]){   //微博
        return [[WeiboManager sharedManager] handleOpenURL:url];
    } else if ([url.scheme isEqualToString:kKidstcAppScheme]){  //公司内部自定义
        return [self handleKidstcApp:url];
    }
    return YES;
}

+ (BOOL)handleKidstcApp:(NSURL *)url{
    
    NSString *urlStr = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([urlStr rangeOfString:kKidstcAppOpenRage].length<=0) {
        TCLog(@"handleKidstcApp---:%@不存在，不做处理！！！",kKidstcAppOpenRage);
        return NO;
    }
    NSRange range = [urlStr rangeOfString:@"content="];
    if (range.length<=0) {
        TCLog(@"handleKidstcApp---:%@不存在，不做处理！！！",@"content=");
        return NO;
    }
    NSString *json = [urlStr substringFromIndex:(range.location+range.length)];
    if (json.length<=0) {
        TCLog(@"handleKidstcApp---:%@不存在，不做处理！！！",@"json");
        return NO;
    }
    NSDictionary *openDic = [NSDictionary dictionaryWithJson:json];
    if (openDic.count<=0) {
        TCLog(@"handleKidstcApp---:%@不存在，不做处理！！！",@"openDic");
        return NO;
    }
    UINavigationController *navi = (UINavigationController *)[TabBarController shareTabBarController].selectedViewController;
    UIViewController *controller = navi.topViewController;
    SegueDestination segueDestination = (SegueDestination)[openDic[@"linkType"] integerValue];
    NSDictionary *param = openDic[@"params"];
    SegueModel *segueModel = [SegueModel modelWithDestination:segueDestination paramRawData:param];
    [SegueMaster makeSegueWithModel:segueModel fromController:controller];
    
    return YES;
}

@end
