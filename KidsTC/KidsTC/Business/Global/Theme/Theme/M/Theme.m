//
//  Theme.m
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Theme.h"
#import "UIImage+Category.h"
#import "UIColor+Category.h"
#import "Macro.h"

NSString *const kUpdataThemeNoti  = @"updataThemeNoti";

@implementation Theme

+ (instancetype)themeWithHomeNavColor:(UIColor *)homeNavColor
                             tabColor:(UIColor *)tabColor
                             elements:(NSArray<TabBarItemElement *> *)elements
{
    Theme *theme = [[Theme alloc] init];
    theme.homeNavColor = homeNavColor;
    theme.tabColor = tabColor;
    theme.elements = elements;
    
    return theme;
}

@end

@implementation TabBarItemElement

+ (instancetype)elementWithType:(TabBarItemElementType)type
                      directory:(NSString *)directory
                          model:(DownloadedTabBarItemElementModel *)model{
    
    TabBarItemElement *element = [[TabBarItemElement alloc]init];
    element.type = type;
    element.title = model.title;
    
    //标题颜色
    UIColor *color_Nor = [UIColor colorWithRGBString:model.titleColorNor];
    if (!color_Nor) return nil;
    element.color_Nor = color_Nor;
    UIColor *color_Sel = [UIColor colorWithRGBString:model.titleColorSel];
    if (!color_Sel) return nil;
    element.color_Sel = color_Sel;
    
    //图标
    NSString *filePathNor = [directory stringByAppendingPathComponent:model.imgNorName];
    UIImage *norImg = [[UIImage imageWithContentsOfFile:filePathNor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (!norImg) return nil;
    element.image_Nor = norImg;
    
    NSString *filePathSel = [directory stringByAppendingPathComponent:model.imgSelName];
    UIImage *selImg = [[UIImage imageWithContentsOfFile:filePathSel] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (!selImg) return nil;
    element.image_Sel = selImg;
    
    return element;
}

+ (instancetype)elementWithType:(TabBarItemElementType)type
                                 title:(NSString *)title
                        image_Nor_name:(NSString *)image_Nor_name
                        image_Sel_name:(NSString *)image_Sel_name
{
    TabBarItemElement *element = [[TabBarItemElement alloc] init];
    element.type = type;
    element.title = title;
    element.color_Nor = RGBA(105, 105, 105, 1);
    element.color_Sel = RGBA(255, 136, 136, 1);
    element.image_Nor = [UIImage imageOriginalWithImageName:image_Nor_name];
    element.image_Sel = [UIImage imageOriginalWithImageName:image_Sel_name];
    return element;
}

+ (instancetype)addEleWithdirectory:(NSString *)directory
                           fImgName:(NSString *)fImgName
                           sImgName:(NSString *)sImgName
                      additionalUrl:(NSString *)additionalUrl
{
    if (directory.length==0) return nil;
    if (fImgName.length==0) return nil;
    if (sImgName.length==0) return nil;
    if (additionalUrl.length==0) return nil;
    
    TabBarItemElement *element = [[TabBarItemElement alloc]init];
    element.type = TabBarItemElementTypeAddLink;
    element.additionalUrl = additionalUrl;
    
    CGFloat width = SCREEN_WIDTH / 5.0;
    //图标
    NSString *filePathNor = [directory stringByAppendingPathComponent:fImgName];
    UIImage *norImg = [UIImage imageWithContentsOfFile:filePathNor];
    if (!norImg) return nil;
    CGFloat fImg_h = norImg.size.height / norImg.size.width * width;
    UIImage *fImg = [[norImg imageByScalingToSize:CGSizeMake(width, fImg_h)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    element.image_Nor = fImg;
    
    NSString *filePathSel = [directory stringByAppendingPathComponent:sImgName];
    UIImage *selImg = [[UIImage imageWithContentsOfFile:filePathSel] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (!selImg) return nil;
    CGFloat sImg_h = selImg.size.height / selImg.size.width * width;
    UIImage *sImg = [[selImg imageByScalingToSize:CGSizeMake(width, sImg_h)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    element.image_Sel = sImg;
    return element;
}

+ (instancetype)addEleWithFImgName:(NSString *)fImgName
                          sImgName:(NSString *)sImgName
{
    TabBarItemElement *element = [[TabBarItemElement alloc]init];
    element.type = TabBarItemElementTypeAddCompose;
    element.image_Nor = [UIImage imageNamed:fImgName];
    element.image_Sel = [UIImage imageNamed:sImgName];
    return element;
}

-(id)copyWithZone:(NSZone *)zone
{
    return [self self_copy];
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return [self self_copy];
}

- (instancetype)self_copy
{
    TabBarItemElement *element = [[TabBarItemElement alloc]init];
    element.type = self.type;
    element.title = self.title;
    element.color_Nor = self.color_Nor;
    element.color_Sel = self.color_Sel;
    element.image_Nor = self.image_Nor;
    element.image_Sel = self.image_Sel;
    element.additionalUrl = self.additionalUrl;
    return element;
}

@end
