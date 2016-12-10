//
//  ProductOrderFreeDetailLotteryModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailLotteryData.h"

@interface ProductOrderFreeDetailLotteryModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductOrderFreeDetailLotteryData *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
