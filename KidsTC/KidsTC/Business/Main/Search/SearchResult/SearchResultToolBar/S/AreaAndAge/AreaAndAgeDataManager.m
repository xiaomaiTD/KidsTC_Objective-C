//
//  AreaAndAgeDataManager.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "AreaAndAgeDataManager.h"
static NSString *const AreaAndAgeFileName = @"AreaAndAge";

@implementation AreaAndAgeDataManager
singleM(AreaAndAgeDataManager)

- (AreaAndAgeModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(AreaAndAgeFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:SYNCHRONIZEDDATA_PATH(AreaAndAgeFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}

- (void)synchronize{
    NSString *md5 = self.model.md5.length>0?self.model.md5:@"";
    NSDictionary *param = @{@"md5":md5,@"last_update_time":@""};
    [Request startAndCallBackInChildThreadWithName:@"MAIN_GET_AGEANDAREA" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[地区和年龄段]:有数据更新");
        AreaAndAgeModel *model = [AreaAndAgeModel modelWithDictionary:dic];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(AreaAndAgeFileName) atomically:YES];
        if(SIMULATOR) [data writeToFile:DESKTOP_SYNCHRONIZEDDATA(AreaAndAgeFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[地区和年龄段]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[地区和年龄段]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[地区和年龄段]:段请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[地区和年龄段]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(AreaAndAgeFileName) error:nil];
    self.model = nil;
}

@end
