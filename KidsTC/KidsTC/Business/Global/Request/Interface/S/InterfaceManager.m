//
//  InterfaceManager.m
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "InterfaceManager.h"
#import "Request.h"

NSString *const interface_listFileName = @"interface_list";

@interface InterfaceManager ()
@property (nonatomic, strong) InterfaceModel *model;
@end

@implementation InterfaceManager
singleM(InterfaceManager)

- (InterfaceModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(interface_listFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:SYNCHRONIZEDDATA_PATH(interface_listFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}

- (void)synchronize{
    
    NSString *cfgver = self.model.version.length>0?self.model.version:@"";
    NSDictionary *param = @{@"cfgver":@"",@"app":@"1",@"appVersion":APP_VERSION};
    TCLog(@"[接口列表]:开始请求，本地cfgver:%@",cfgver);
    [Request startAndCallBackInChildThreadWithName:@"MAIN_GETINTERFACE" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[接口列表]:有新数据");
        InterfaceModel *model = [InterfaceModel modelWithDictionary:dic];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(interface_listFileName) atomically:YES];
        if(SIMULATOR) [data writeToFile:DESKTOP_SYNCHRONIZEDDATA(interface_listFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[接口列表]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[接口列表]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[接口列表]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[接口列表]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(interface_listFileName) error:nil];
    self.model = nil;
}

- (InterfaceItem *)interfaceItemWithName:(NSString *)name{
    return [self.model interfaceItemWithName:name];
}

@end
