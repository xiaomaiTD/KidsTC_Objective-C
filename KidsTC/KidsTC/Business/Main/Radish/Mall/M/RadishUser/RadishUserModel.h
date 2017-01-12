//
//  RadishUserModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishUserData.h"

@interface RadishUserModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RadishUserData *data;
@end
