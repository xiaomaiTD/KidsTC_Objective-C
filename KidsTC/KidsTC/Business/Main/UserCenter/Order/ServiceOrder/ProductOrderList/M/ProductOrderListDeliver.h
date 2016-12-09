//
//  ProductOrderListDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderListDeliverItem.h"
//deliverInfo	String	童成客服已经发货，运单号：${DeliveryNo}；
//请您注意查收。客服联系方式：${Mobile}
//items	Array
@interface ProductOrderListDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<ProductOrderListDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attDeliverInfo;
@end
