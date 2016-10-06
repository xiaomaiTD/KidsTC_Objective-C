//
//  SearchHotKeywordsManager.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHotKeywordsManager.h"
static NSString *const SearchHotKeywordsFileName = @"SearchHotKeywords";

@implementation SearchHotKeywordsManager
singleM(SearchHotKeywordsManager)

- (SearchHotKeywordsModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(SearchHotKeywordsFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:SYNCHRONIZEDDATA_PATH(SearchHotKeywordsFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}
- (void)synchronize{
    
    NSString *md5 = self.model.md5.length>0?self.model.md5:@"";
    NSString *pt = [User shareUser].role.roleIdentifierString;
    NSDictionary *param = @{@"md5":md5,@"pt":pt};
    [Request startAndCallBackInChildThreadWithName:@"SEARCH_GET_HOTKEY" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[热搜关键字]:有更新数据");
        SearchHotKeywordsModel *model = [SearchHotKeywordsModel modelWithDictionary:dic];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(SearchHotKeywordsFileName) atomically:YES];
        if(SIMULATOR) [data writeToFile:DESKTOP_SYNCHRONIZEDDATA(SearchHotKeywordsFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[热搜关键字]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[热搜关键字]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[热搜关键字]:段请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[热搜关键字]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(SearchHotKeywordsFileName) error:nil];
    self.model = nil;
}


@end
