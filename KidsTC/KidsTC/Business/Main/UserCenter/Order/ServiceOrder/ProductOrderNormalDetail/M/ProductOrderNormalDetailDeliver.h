//
//  ProductOrderNormalDetailDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderNormalDetailDeliverItem.h"

@interface ProductOrderNormalDetailDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<ProductOrderNormalDetailDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSString *deliverStr;
@end
