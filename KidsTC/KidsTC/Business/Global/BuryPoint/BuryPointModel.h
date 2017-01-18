//
//  BuryPointModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/7.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuryPointModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *pk;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL hasDealWith;
+ (instancetype)modelWithPk:(NSString *)pk content:(NSString *)content;
@end
