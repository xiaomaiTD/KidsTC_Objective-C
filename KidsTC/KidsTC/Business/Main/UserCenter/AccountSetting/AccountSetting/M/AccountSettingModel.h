//
//  AccountSettingModel.h
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountSettingModel : NSObject
@property (nonatomic, strong) NSString *headerUrl;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *mobile;
+(instancetype)modelWithHeaderUrl:(NSString *)headUrl userName:(NSString *)userName mobile:(NSString *)mobile;
@end
