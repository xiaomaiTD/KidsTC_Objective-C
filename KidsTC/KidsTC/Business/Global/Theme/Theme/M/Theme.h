//
//  Theme.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeModel.h"

extern NSString *const kUpdataThemeNoti;//重新更新主题通知

@class TabBarItemElement;
@interface Theme : NSObject
@property (nonatomic, strong) UIColor *tabColor;//tab栏背景色
@property (nonatomic, strong) UIColor *homeNavColor;//首页导航栏背景色
@property (nonatomic, strong) NSArray<TabBarItemElement *> *elements;//tabbarItem元素
+ (instancetype)themeWithHomeNavColor:(UIColor *)homeNavColor
                             tabColor:(UIColor *)tabColor
                             elements:(NSArray<TabBarItemElement *> *)elements;
@end


typedef NS_ENUM(NSInteger, TabBarItemElementType) {
    TabBarItemElementTypeHome=1,       //首页
    TabBarItemElementTypeArticle,      //资讯
    TabBarItemElementTypeStrategy,     //亲子攻略
    TabBarItemElementTypeUserCenter,   //我
    TabBarItemElementTypeAddLink,      //附加-活动
    TabBarItemElementTypeAddCompose    //附加-发布
};
@interface TabBarItemElement : NSObject<NSCopying,NSMutableCopying>
@property (nonatomic, assign) TabBarItemElementType type;//tab类型
@property (nonatomic, strong) NSString *title;    //按钮标题
@property (nonatomic, strong) UIColor  *color_Nor;//标题颜色 （普通）
@property (nonatomic, strong) UIColor  *color_Sel;//标题颜色 （高亮）
@property (nonatomic, strong) UIImage  *image_Nor;//图片（普通）
@property (nonatomic, strong) UIImage  *image_Sel;//图片（选中）
@property (nonatomic, strong) NSString *additionalUrl;//附加tabBarItem的网页地址

+ (instancetype)elementWithType:(TabBarItemElementType)type
                      directory:(NSString *)directory
                          model:(DownloadedTabBarItemElementModel *)model;

+ (instancetype)elementWithType:(TabBarItemElementType)type
                          title:(NSString *)title
                 image_Nor_name:(NSString *)image_Nor_name
                 image_Sel_name:(NSString *)image_Sel_name;

+ (instancetype)addEleWithdirectory:(NSString *)directory
                           fImgName:(NSString *)fImgName
                           sImgName:(NSString *)sImgName
                      additionalUrl:(NSString *)additionalUrl;

+ (instancetype)addEleWithFImgName:(NSString *)fImgName
                          sImgName:(NSString *)sImgName;
@end
