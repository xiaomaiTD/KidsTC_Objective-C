//
//  ProductOrderListAllTitleRowItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderListAllTitleRowItemActionTypeFlash = 1,
    ProductOrderListAllTitleRowItemActionTypeSecondKill,
    ProductOrderListAllTitleRowItemActionTypeAppoinment,
    ProductOrderListAllTitleRowItemActionTypeRadish,
} ProductOrderListAllTitleRowItemActionType;

@interface ProductOrderListAllTitleRowItem : NSObject
@property (nonatomic, assign) ProductOrderListAllTitleRowItemActionType actionType;
@end
