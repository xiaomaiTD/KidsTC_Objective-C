//
//  Macro.h
//  KidsTC
//
//  Created by 詹平 on 16/7/15.
//  Copyright © 2016年 詹平. All rights reserved.
//

#define URL_APP_STORE_UPDATE ([NSString stringWithFormat: @"http://itunes.apple.com/cn/app/id%@", kAppIDInAppStore])

#pragma mark - 获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - pageCount
#define TCPAGECOUNT 10

#pragma mark - 获取app版本号
#define APP_VERSION [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

#pragma mark - 获取系统版本号
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - Log
#ifdef DEBUG
#define TCLog(...) NSLog(@"%s 第%d行\n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define TCLog(...)
#endif

#pragma mark - 判断是否为模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#pragma mark - standardUserDefaults
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#pragma mark - 弱引用/强引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark - 获取通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - 沙盒目录文件
//获取temp
#define PathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define FILE_CACHE_PATH(path) [PathCache stringByAppendingPathComponent:(path)]

#pragma mark - bundle目录文件
#define RESOURCES_BUNDLE_PATH [[NSBundle mainBundle] pathForResource:@"Resources" ofType:@"bundle"]
#define SYNCHRONIZEDDATA_PATH(path) \
[[NSBundle bundleWithPath:RESOURCES_BUNDLE_PATH]\
pathForResource:path ofType:@"" inDirectory:@"SynchronizedData"]

#pragma mark - 颜色
//设置随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//设置RGB颜色/设置RGBA颜色
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/225.0 green:(g)/225.0 blue:(b)/225.0 alpha:a]

#pragma mark - 线条的细度
#define LINE_H 1/[UIScreen mainScreen].scale

#pragma mark - 颜色
#define COLOR_NAVI RGB(255,136,136) //导航栏背景色
#define COLOR_PINK RGB(255,136,136) //粉色
#define COLOR_PINK_HIGHLIGHT RGB(255,50,50) //深粉色
#define COLOR_PINK_FLASH [UIColor colorWithRed:1  green:0.599  blue:0.712 alpha:1]//闪购粉色
#define COLOR_BLUE RGB(103,216,244) //蓝色
#define COLOR_YELL [UIColor colorWithRed:0.938  green:0.479  blue:0.065 alpha:1]  //黄色
#define COLOR_LINE [[UIColor lightGrayColor] colorWithAlphaComponent:0.3] //线条颜色
#define COLOR_BG RGB(246, 246, 246) //全局背景色
#define COLOR_BG_CEll RGB(255, 255, 255) //全局背景色
#define COLOR_TEXT RGB(153, 153, 153)//文本颜色
//商品详情颜色
#define PRODUCT_DETAIL_RED [UIColor colorWithRed:0.945 green:0.412 blue:0.400 alpha:1]//红色
#define PRODUCT_DETAIL_BLUE [UIColor colorWithRed:0.455 green:0.694 blue:0.910 alpha:1]//蓝色

#pragma mark - 站位图片
#define PLACEHOLDERIMAGE_SMALL ([UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]])
#define PLACEHOLDERIMAGE_BIG ([UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]])
#define PLACEHOLDERIMAGE_SMALL_LOG ([UIImage imageNamed:@"placeholder_50_50"])
#define PLACEHOLDERIMAGE_BIG_LOG ([UIImage imageNamed:@"placeholder_100_100"])

#pragma mark - 桌面同步路径
#define DESKTOP_SYNCHRONIZEDDATA(path) [NSString stringWithFormat:@"/Users/zhanping/Desktop/SynchronizedData/%@",path]



