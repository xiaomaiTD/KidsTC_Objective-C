//
//  ProductStandardDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductStandardDetailStore.h"

@interface ProductStandardDetailData : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *chid;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) NSString *storePrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) NSUInteger minBuyNum;
@property (nonatomic, assign) NSUInteger maxBuyNum;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *remainStock;
@property (nonatomic, strong) NSArray<ProductStandardDetailStore *> *stores;

@property (nonatomic, assign) BOOL isCanBuy;
@end
