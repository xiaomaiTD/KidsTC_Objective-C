//
//  SeckillDataModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillDataData.h"
@interface SeckillDataModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) SeckillDataData *data;
@end
