//
//  ThemeManager.m
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ThemeManager.h"
#import "SSZipArchive.h"
#import "ThemeModel.h"
#import "UIColor+Category.h"
#import "AddTabManager.h"
static NSString *const ThemeDirectoryName = @"Theme";
static NSString *const ThemeModelFileName = @"Theme/ThemeModel";
static NSString *const ThemeZipFileName   = @"Theme/ThemeZip.zip";
static NSString *const ThemeConfigFileName = @"config";


@interface ThemeManager ()
@property (nonatomic, strong) ThemeModel *model;
@property (nonatomic, strong) ThemeDownloadedConfigModel *downloadedConfigModel;
@end

@implementation ThemeManager
singleM(ThemeManager)

- (ThemeModel *)model{
    if (!_model) {
        NSString *filePath = FILE_CACHE_PATH(ThemeModelFileName);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
           _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return _model;
}

- (ThemeDownloadedConfigModel *)downloadedConfigModel{
    if (!_downloadedConfigModel) {
        NSString *configPath = [NSString stringWithFormat:@"%@/%@", FILE_CACHE_PATH(ThemeDirectoryName), ThemeConfigFileName];
        NSData *data = [NSData dataWithContentsOfFile:configPath];
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            ThemeDownloadedConfigModel *model = [ThemeDownloadedConfigModel modelWithDictionary:dic];
            if ([self isDonwnloadThemeConfigValid:model]) {//本地主题有效
                _downloadedConfigModel = model;
            }else{//本地主题包无效，清除本地主题包
                [self removeLocalTheme];
                return nil;
            }
        }else{
            [self removeLocalTheme];
            return nil;
        }
    }
    return _downloadedConfigModel;
}

- (Theme *)theme{
    if (!_theme) {
        _theme = [self localTheme];
    }
    if (!_theme) {
        _theme = [self codedTheme];
    }
    if (_theme) {
        [self addAdditionalElement];
    }
    return _theme;
}

#pragma mark - synchronize

- (void)synchronize{
    
    NSString *version = self.model.data.version;
    if (!version) version = @"";
    TCLog(@"[主题包配置文件]:开始请求，本地版本号：%@",version);
    NSDictionary *param = @{@"version":version};
    [Request startAndCallBackInChildThreadWithName:@"GET_HOME_THEME" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[主题包配置文件]:请求成功--%@",[NSThread currentThread]);
        ThemeModel *model = [ThemeModel modelWithDictionary:dic];
        if ([self.model.data.version isEqualToString:model.data.version]){
            TCLog(@"[主题包配置文件]:版本号一致,不需要更新");
            return;
        };
        if (model.data.downLink.length<=0) {
            TCLog(@"[主题包配置文件]:下载链接为空，无法下载");
            return;
        };
        [self downloadThemeZipWithModel:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[主题包配置文件]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[主题包配置文件]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)downloadThemeZipWithModel:(ThemeModel *)model{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:model.data.downLink];
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            TCLog(@"主题包下载成功");
            [self downZipSuccess:data model:model];
        }else{
            TCLog(@"主题包下载失败");
        }
    }];
    [dataTask resume];
}

- (void)downZipSuccess:(NSData *)data model:(ThemeModel *)model{
    
    NSError *err = nil;
    NSString *destination = FILE_CACHE_PATH(ThemeDirectoryName);
    [[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:&err];
    if (!err) {
        TCLog(@"主题包文件夹创建成功");
        NSString *filePath = FILE_CACHE_PATH(ThemeZipFileName);
        BOOL bWrite = [data writeToFile:filePath atomically:YES];
        if (bWrite) {
            TCLog(@"主题包写入成功");
            BOOL bUnzip = [SSZipArchive unzipFileAtPath:filePath toDestination:destination];
            if (bUnzip) {
                TCLog(@"主题包解压成功");
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                BOOL bModelWrite = [data writeToFile:FILE_CACHE_PATH(ThemeModelFileName) atomically:YES];
                if (bModelWrite) {
                    TCLog(@"主题包配置模型写入成功");
                    TCLog(@"主题包--Thread--:%@",[NSThread currentThread]);
                    self.downloadedConfigModel = nil;
                    self.model = nil;
                    self.theme = nil;
                    [self reUpDataTheme];
                }else{
                    TCLog(@"主题包配置模型写入失败");
                    [self removeLocalTheme];
                }
            }else{
                TCLog(@"主题包解压失败");
                [self removeLocalTheme];
            };
        }else{
            TCLog(@"主题包写入失败");
            [self removeLocalTheme];
        }
    }else{
        TCLog(@"主题包文件夹创建失败");
    }
}

- (void)removeLocalTheme{
    if (self.model) {
        [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(ThemeDirectoryName) error:nil];
        self.downloadedConfigModel = nil;
        self.model = nil;
        self.theme = nil;
        [self reUpDataTheme];
    }
}

- (void)reUpDataTheme{
    dispatch_async(dispatch_get_main_queue(), ^{
       [NotificationCenter postNotificationName:kUpdataThemeNoti object:nil];
    });
}

#pragma mark - helpers

//本地主题包配置文件是否有效
- (BOOL)isDonwnloadThemeConfigValid:(ThemeDownloadedConfigModel *)model
{
    if (!model) return NO;
    NSTimeInterval nowaTimeInterval = [[NSDate date] timeIntervalSince1970];
    if (nowaTimeInterval < model.startTime) return NO; //未开始
    if (nowaTimeInterval > model.expireTime) return NO; //已过期
    if (model.topColor.length == 0) return NO; //导航栏数据无效
    if (model.bgColor.length == 0) return NO; //tab栏数据无效
    if (!model.home) return NO;//首页数据无效
    if (!model.news) return NO;//知识库数据无效
    if (!model.strategy) return NO;//亲子攻略数据无效
    if (!model.me) return NO;//用户中心数据无效
    return YES;
}
//从本地拿主题
- (Theme *)localTheme{
    
    ThemeDownloadedConfigModel *model = self.downloadedConfigModel;
    if (!model) return nil;
    
    NSString *directory = FILE_CACHE_PATH(ThemeDirectoryName);
    
    TabBarItemElement *element1 = [TabBarItemElement elementWithType:TabBarItemElementTypeHome
                                                           directory:directory
                                                               model:model.home];
    if (!element1) return nil;
    TabBarItemElement *element2 = [TabBarItemElement elementWithType:TabBarItemElementTypeArticle
                                                           directory:directory
                                                               model:model.news];
    if (!element2) return nil;
    TabBarItemElement *element3 = [TabBarItemElement elementWithType:TabBarItemElementTypeStrategy
                                                           directory:directory
                                                               model:model.strategy];
    if (!element3) return nil;
    TabBarItemElement *element4 = [TabBarItemElement elementWithType:TabBarItemElementTypeUserCenter
                                                           directory:directory
                                                               model:model.me];
    if (!element4) return nil;
    NSArray<TabBarItemElement *> *elements = @[element1,element2,element3,element4];
    
    UIColor *homeNavColor = [UIColor colorWithRGBString:model.topColor];
    if (!homeNavColor) return nil;
    
    UIColor *tabColor = [UIColor colorWithRGBString:model.bgColor];
    if (!tabColor) return nil;
    
    Theme *theme = [Theme themeWithHomeNavColor:homeNavColor tabColor:tabColor elements:elements];
    
    return theme;
}
//从代码生成主题
- (Theme *)codedTheme{
    
    TabBarItemElement *element1 = [TabBarItemElement elementWithType:TabBarItemElementTypeHome
                                                               title:@"首页"
                                                      image_Nor_name:@"tabbar_home_n"
                                                      image_Sel_name:@"tabbar_home_h"];
    
    TabBarItemElement *element2 = [TabBarItemElement elementWithType:TabBarItemElementTypeArticle
                                                               title:@"有料"
                                                      image_Nor_name:@"tabbar_discovery_n"
                                                      image_Sel_name:@"tabbar_discovery_h"];
    
    TabBarItemElement *element3 = [TabBarItemElement elementWithType:TabBarItemElementTypeStrategy
                                                               title:@"亲子攻略"
                                                      image_Nor_name:@"tabbar_parantingStrategy_n"
                                                      image_Sel_name:@"tabbar_parantingStrategy_h"];
    
    TabBarItemElement *element4 = [TabBarItemElement elementWithType:TabBarItemElementTypeUserCenter
                                                               title:@"我"
                                                      image_Nor_name:@"tabbar_userCenter_n"
                                                      image_Sel_name:@"tabbar_userCenter_h"];
    
    NSArray<TabBarItemElement *> *elements = @[element1,element2,element3,element4];
    
    UIColor *homeNavColor = COLOR_PINK;
    UIColor *tabColor = RGBA(252, 248, 245, 1);
    
    Theme *theme = [Theme themeWithHomeNavColor:homeNavColor tabColor:tabColor elements:elements];
    
    return theme;
}

- (void)addAdditionalElement{
    __block BOOL needInset = YES;
    [_theme.elements enumerateObjectsUsingBlock:^(TabBarItemElement *obj, NSUInteger idx, BOOL *stop) {
        if (obj.type == TabBarItemElementTypeAddLink ||
            obj.type == TabBarItemElementTypeAddCompose)
        {
            needInset = NO;
            *stop = YES;
        }
    }];
    NSMutableArray *elements = [_theme.elements mutableCopy];
    TabBarItemElement *addEle = [AddTabManager shareAddTabManager].addElement;
    if (addEle && elements.count>=2) {
        if (needInset) {
            [elements insertObject:addEle atIndex:2];
        }else{
            [elements replaceObjectAtIndex:2 withObject:addEle];
        }
    }
    _theme.elements = elements;
}

@end
