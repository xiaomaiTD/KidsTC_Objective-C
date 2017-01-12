//
//  SeckillTimeModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillTimeData.h"
@interface SeckillTimeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) SeckillTimeData *data;
@end
