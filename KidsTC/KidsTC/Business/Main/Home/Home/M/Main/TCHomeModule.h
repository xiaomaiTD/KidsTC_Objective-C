//
//  TCHomeModule.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCHomeFloor;

@interface TCHomeModule : NSObject
@property (nonatomic, assign) BOOL type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<TCHomeFloor *> *floors;

@property (nonatomic, assign) NSUInteger index;
@end
