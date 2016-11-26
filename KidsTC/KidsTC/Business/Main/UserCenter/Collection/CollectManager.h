//
//  CollectManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CollectTypeNormalProduct,
    CollectTypeStore,
    CollectTypeStrategy,
    CollectTypeNews,
    CollectTypeTicketProduct,
    CollectTypeFreeProduct,
} CollectType;

@interface CollectManager : NSObject


@end
