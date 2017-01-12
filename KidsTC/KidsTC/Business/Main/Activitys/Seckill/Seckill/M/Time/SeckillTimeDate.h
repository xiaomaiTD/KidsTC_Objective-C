//
//  SeckillTimeDate.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillTimeTime.h"
@interface SeckillTimeDate : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, strong) NSString *poolSysNo;
@property (nonatomic, strong) NSArray<SeckillTimeTime *> *tabs;
@end
