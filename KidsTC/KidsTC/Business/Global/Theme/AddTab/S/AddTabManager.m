//
//  AddTabManager.m
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddTabManager.h"
#import "AddTabModel.h"
#import "NSString+Category.h"
#import "ComposeManager.h"

static NSString *const AddTabDirectoryName = @"AddTab";
static NSString *const AddTabModelFileName = @"AddTab/AddTabModel";
static NSString *const fImgDataName = @"fImg";
static NSString *const sImgDataName = @"sImg";

@interface AddTabManager ()
@property (nonatomic, strong) AddTabModel *model;
@end

@implementation AddTabManager

singleM(AddTabManager)

- (AddTabModel *)model{
    if (!_model) {
        NSString *filePath = FILE_CACHE_PATH(AddTabModelFileName);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return _model;
}

- (TabBarItemElement *)addElement{
    if (!_addElement) {
        _addElement = [self localEle];
    }
    if (!_addElement) {
        _addElement = [self codedEle];
    }
    return _addElement;
}

- (void)synchronize{
    NSString *key = self.model.md5.length>0?self.model.md5:@"";
    TCLog(@"[AddTab配置文件]:开始请求，本地md5：%@",key);
    NSDictionary *param = @{@"key":key};
    [Request startAndCallBackInChildThreadWithName:@"GET_HOME_TAB" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[AddTab配置文件]:请求成功--%@",[NSThread currentThread]);
        AddTabModel *model = [AddTabModel modelWithDictionary:dic];
        [self responseSuccess:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[AddTab配置文件]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[AddTab配置文件]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)responseSuccess:(AddTabModel *)model{
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    __block UIImage *fImg = nil;
    __block NSData *fImgData = nil;
    __block UIImage *sImg = nil;
    __block NSData *sImgData = nil;
    dispatch_group_async(group, queue, ^{
        TCLog(@"AddTab两张图片--%@",[NSThread currentThread]);
        fImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.data.fImg]];
        fImg = [UIImage imageWithData:fImgData];
    });
    dispatch_group_async(group, queue, ^{
        TCLog(@"AddTab两张图片--%@",[NSThread currentThread]);
        sImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.data.sImg]];
        sImg = [UIImage imageWithData:sImgData];
    });
    dispatch_group_notify(group, queue, ^{
        if (fImg && sImg){
            TCLog(@"AddTab两张图片下载成功：\nfImg:%@\nsImg:%@",fImg,sImg);
            [self downPicSuccessWithfImgData:fImgData sImgData:sImgData model:model];
        }else{
            TCLog(@"AddTab两张图片下载失败：\nfImg:%@\nsImg:%@",fImg,sImg);
        };
    });
}

- (void)downPicSuccessWithfImgData:(NSData *)fImgData sImgData:(NSData *)sImgData model:(AddTabModel *)model{
    
    NSString *destination = FILE_CACHE_PATH(AddTabDirectoryName);
    NSError *err = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:&err];
    if (!err) {
        TCLog(@"AddTab文件目录创建成功");
        NSString *fImgPath = [destination stringByAppendingPathComponent:fImgDataName];
        BOOL bfImg = [fImgData writeToFile:fImgPath atomically:YES];
        NSString *sImgPath = [destination stringByAppendingPathComponent:sImgDataName];
        BOOL bsImg = [sImgData writeToFile:sImgPath atomically:YES];
        if (bfImg && bsImg) {
            TCLog(@"AddTab两张图片写入成功");
            model.downloaded = YES;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            BOOL bModelWrite = [data writeToFile:FILE_CACHE_PATH(AddTabModelFileName) atomically:YES];
            if (bModelWrite) {
                TCLog(@"AddTab配置模型写入成功--Thread--:%@",[NSThread currentThread]);
                self.model = nil;
                self.addElement = nil;
                [self reUpDataTheme];
            }else{
                TCLog(@"AddTab配置模型写入失败");
                [self removeLocalTheme];
            }
        }else{
            TCLog(@"AddTab两张图片写入失败--bfImg:%zd bsImg:%zd",bfImg,bsImg);
            [self removeLocalTheme];
        }
    }else{
        TCLog(@"AddTab文件目录创建失败");
    }
}

- (void)removeLocalTheme{
    if (self.model) {//本地有，则移除
        [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(AddTabDirectoryName) error:nil];
        self.model = nil;
        self.addElement = nil;
        [self reUpDataTheme];
    }
}

- (void)reUpDataTheme{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NotificationCenter postNotificationName:kUpdataThemeNoti object:nil];
    });
}

- (TabBarItemElement *)localEle{
    if (self.model.downloaded) {
        NSString *directory = FILE_CACHE_PATH(AddTabDirectoryName);
        TabBarItemElement *addEle = [TabBarItemElement addEleWithdirectory:directory
                                                                  fImgName:fImgDataName
                                                                  sImgName:sImgDataName
                                                             additionalUrl:self.model.data.url];
        return addEle;
    }
    return nil;
}

- (TabBarItemElement *)codedEle{
    ComposeData *data = [ComposeManager shareComposeManager].model.data.data;
    if (data) {
        return [TabBarItemElement addEleWithFImgName:@"tabBar_compose" sImgName:@"tabBar_compose_cancle"];
    }else{
        return nil;
    }
}

- (NSString *)composeImgName {
    NSString *deviceName = [NSString getCurrentDeviceModel];
    /*
     if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
     if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
     if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
     if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
     if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
     if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
     if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
     if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
     if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
     if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
     if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
     if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
     if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
     if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
     if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
     if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
     if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
     if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
     if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
     if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
     if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
     */
    if ([deviceName isEqualToString:@"iPhone4"]||
        [deviceName isEqualToString:@"iPhone4S"]||
        [deviceName isEqualToString:@"iPhone5"]||
        [deviceName isEqualToString:@"iPhone5c"]||
        [deviceName isEqualToString:@"iPhone5s"]||
        [deviceName isEqualToString:@"iPhoneSE"]) {
        return @"compose_5";
    }else if ([deviceName isEqualToString:@"iPhone6"]||
              [deviceName isEqualToString:@"iPhone6s"]||
              [deviceName isEqualToString:@"iPhone7"]) {
        return @"compose_6";
    }else if ([deviceName isEqualToString:@"iPhone6Plus"]||
              [deviceName isEqualToString:@"iPhone6sPlus"]||
              [deviceName isEqualToString:@"iPhone7Plus"]) {
        return @"compose_6p";
    }
    return @"compose_6";
}
@end
