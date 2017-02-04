//
//  NormalProductDetailTime.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailTimeItem.h"
@interface NormalProductDetailTime : NSObject
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray<NormalProductDetailTimeItem *> *times;
@end
