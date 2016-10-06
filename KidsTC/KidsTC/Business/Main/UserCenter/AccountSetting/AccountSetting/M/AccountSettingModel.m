//
//  AccountSettingModel.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AccountSettingModel.h"

@implementation AccountSettingModel
+(instancetype)modelWithHeaderUrl:(NSString *)headUrl userName:(NSString *)userName mobile:(NSString *)mobile{
    AccountSettingModel *model = [[AccountSettingModel alloc]init];
    model.headerUrl = headUrl;
    model.userName = userName;
    if (mobile.length>7) mobile = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    model.mobile = mobile;
    return model;
}
@end
