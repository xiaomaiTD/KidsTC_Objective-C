//
//  SeckillOtherItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillOtherFloorItem.h"
@interface SeckillOtherItem : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSArray<SeckillOtherFloorItem *> *floorItems;
@property (nonatomic, assign) BOOL selected;
//selfDefine
@property (nonatomic, strong) NSArray<SeckillOtherFloorItem *> *items;
@end
