//
//  SeckillOtherFloorItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillOtherContent.h"

@interface SeckillOtherFloorItem : NSObject
@property (nonatomic, strong) NSString *sortNo;
@property (nonatomic, strong) NSString *floorSysNo;
@property (nonatomic, assign) NSUInteger contentType;
@property (nonatomic, strong) NSString *marginTop;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSArray<SeckillOtherContent *> *contents;
//selfDefine
@property (nonatomic, strong) SeckillOtherContent *content;
@end
