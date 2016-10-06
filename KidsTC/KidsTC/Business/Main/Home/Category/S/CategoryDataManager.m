//
//  CategoryManager.m
//  KidsTC
//
//  Created by zhanping on 6/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "CategoryDataManager.h"
NSString *const CategoryFileName = @"Category";

@implementation CategoryDataManager
singleM(CategoryDataManager)

- (CategoryModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(CategoryFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:SYNCHRONIZEDDATA_PATH(CategoryFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}

- (void)synchronize{
    
    NSString *md5 = self.model.md5.length>0?self.model.md5:@"";
    NSDictionary *param = @{@"md5":md5,@"last_update_time":@""};
    [Request startAndCallBackInChildThreadWithName:@"CATEGORY_GET" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[分类]:有新数据");
        CategoryModel *model = [CategoryModel modelWithDictionary:dic];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(CategoryFileName) atomically:YES];
        if(SIMULATOR) [data writeToFile:DESKTOP_SYNCHRONIZEDDATA(CategoryFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[分类]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[分类]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[分类]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[分类]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(CategoryFileName) error:nil];
    self.model = nil;
}
@end
