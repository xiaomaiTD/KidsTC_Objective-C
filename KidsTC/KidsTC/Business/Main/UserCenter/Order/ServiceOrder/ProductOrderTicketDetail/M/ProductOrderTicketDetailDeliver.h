//
//  ProductOrderTicketDetailDeliver.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderTicketDetailDeliverItem.h"

@interface ProductOrderTicketDetailDeliver : NSObject
@property (nonatomic, strong) NSString *deliverInfo;
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailDeliverItem *> *items;
//selfDefine
@property (nonatomic, strong) NSString *deliverStr;
@end
