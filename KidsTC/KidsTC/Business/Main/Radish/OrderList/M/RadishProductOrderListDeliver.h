//
//  RadishProductOrderListDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListDeliverItem.h"

@interface RadishProductOrderListDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<RadishProductOrderListDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSString *deliverStr;
@end
