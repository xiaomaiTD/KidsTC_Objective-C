//
//  WholesalePickDateSKU.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesalePickDateTime.h"
#import "WholesalePickDatePlace.h"

typedef enum : NSUInteger {
    WholesalePickDateSKUBtnTypeBuy = 100,
    WholesalePickDateSKUBtnTypeMakeSure,
} WholesalePickDateSKUBtnType;

@interface WholesalePickDateSKU : NSObject
@property (nonatomic, assign) BOOL isShowTime;
@property (nonatomic, strong) NSArray<WholesalePickDateTime *> *times;
//selfDefine
@property (nonatomic, assign) WholesalePickDateSKUBtnType type;
@property (nonatomic, strong) NSArray<WholesalePickDatePlace *> *places;
@end
