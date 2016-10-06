//
//  AddressDataManager.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddressDataManager.h"
#import "GHeader.h"

static NSString *const AddressFileName = @"Address";

@implementation AddressDataManager
singleM(AddressDataManager)

- (AddressModel *)model{
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:FILE_CACHE_PATH(AddressFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!_model) {
        NSData *data = [NSData dataWithContentsOfFile:SYNCHRONIZEDDATA_PATH(AddressFileName)];
        if (data) _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _model;
}

- (void)synchronize{
    NSString *md5 = self.model.md5.length>0?self.model.md5:@"";
    NSDictionary *param = @{@"md5":md5};
    [Request startAndCallBackInChildThreadWithName:@"ADDRESS_GET_TO_THREE_LEVEL" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"[购物地址]:有新的数据");
        AddressModel *model = [AddressModel modelWithDictionary:dic];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        BOOL bWrite = [data writeToFile:FILE_CACHE_PATH(AddressFileName) atomically:YES];
        if(SIMULATOR) [data writeToFile:DESKTOP_SYNCHRONIZEDDATA(AddressFileName) atomically:YES];
        if (bWrite) {
            TCLog(@"[购物地址]:写入成功");
            self.model = model;
        }else{
            TCLog(@"[购物地址]:写入失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            TCLog(@"[购物地址]:请求失败--移除本地--%@",[NSThread currentThread]);
            [self removeLocalTheme];
        }else{
            TCLog(@"[购物地址]:请求失败--不作处理--%@",[NSThread currentThread]);
        }
    }];
}

- (void)removeLocalTheme{
    [[NSFileManager defaultManager] removeItemAtPath:FILE_CACHE_PATH(AddressFileName) error:nil];
    self.model = nil;
}
@end
