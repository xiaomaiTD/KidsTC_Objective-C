//
//  AccountCenterUserInfo.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccountCenterUserInfo : NSObject
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *levelName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSUInteger age;
@end
