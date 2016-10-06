//
//  RegisterModel.h
//  KidsTC
//
//  Created by 詹平 on 16/7/17.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterData : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *skey;
@end

@interface RegisterModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RegisterData *data;
@end

