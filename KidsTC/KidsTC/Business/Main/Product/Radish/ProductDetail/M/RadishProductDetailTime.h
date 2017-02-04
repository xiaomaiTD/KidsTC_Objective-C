//
//  RadishProductDetailTime.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTimeItem.h"

@interface RadishProductDetailTime : NSObject
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray<RadishProductDetailTimeItem *> *times;
@end
