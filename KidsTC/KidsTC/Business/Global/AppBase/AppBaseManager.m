//
//  AppBaseManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AppBaseManager.h"
#import "GHeader.h"
@implementation AppBaseManager
singleM(AppBaseManager)
- (void)synchronize {
    [Request startAndCallBackInChildThreadWithName:@"GET_APP_BASE" param:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        _data = [AppBaseModel modelWithDictionary:dic].data;
    } failure:nil];
}
@end
