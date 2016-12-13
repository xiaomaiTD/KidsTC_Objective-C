//
//  ProductOrderListDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderListDeliverItem.h"

@interface ProductOrderListDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<ProductOrderListDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSString *deliverStr;
@end
