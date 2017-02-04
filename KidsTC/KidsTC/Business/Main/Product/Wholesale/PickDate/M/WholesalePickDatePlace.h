//
//  WholesalePickDatePlace.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WholesalePickDatePlace : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
//selfDefine
@property (nonatomic, assign) BOOL select;
@end
