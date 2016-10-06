//
//  LoginModel.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LoginTypeKidTC,
    LoginTypeQQ,
    LoginTypeWechat,
    LoginTypeWeibo
}LoginType;
@interface LoginItemModel : NSObject
@property (nonatomic, assign) LoginType type;
@property (nonatomic, strong) NSString *loginDescription;
@property (nonatomic, strong) UIImage *logo;
@end

@interface LoginData : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *skey;
@end

@interface LoginModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) LoginData *data;
@end
