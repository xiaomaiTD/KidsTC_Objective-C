//
//  RadishOrderDetailDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishOrderDetailDeliverItem.h"

@interface RadishOrderDetailDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<RadishOrderDetailDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSString *deliverStr;
@end
