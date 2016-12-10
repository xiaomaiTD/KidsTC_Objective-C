//
//  ProductOrderFreeDetailLotteryData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailLotteryItem.h"

@interface ProductOrderFreeDetailLotteryData : NSObject
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailLotteryItem *> *ResultLists;
@property (nonatomic, assign) NSInteger Count;
@property (nonatomic, assign) BOOL IsSuccess;
@property (nonatomic, strong) NSString *ResultMessage;
@end
