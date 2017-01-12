//
//  SeckillTimeData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillTimeDate.h"
#import "SeckillTimeShare.h"
#import "SeckillTimeEventMenu.h"
#import "CommonShareObject.h"
#import "SeckillTimeToolBarItem.h"

@interface SeckillTimeData : NSObject
@property (nonatomic, strong) NSArray<SeckillTimeDate *> *tabs;
@property (nonatomic, strong) SeckillTimeShare *share;
@property (nonatomic, strong) SeckillTimeEventMenu *eventMenu;
@property (nonatomic, strong) NSString *eventName;
//selfDefine
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, strong) NSArray<SeckillTimeToolBarItem *> *toolBarItems;
@end
