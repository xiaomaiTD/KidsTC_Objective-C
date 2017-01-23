//
//  FlashBuyProductDetailPriceConfig.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FlashBuyProductDetailPriceConfigNoAchieved=1,//未达到
    FlashBuyProductDetailPriceConfigFlashing,//进行中
    FlashBuyProductDetailPriceConfigAchieved,//已达到
    FlashBuyProductDetailPriceConfigCurrentAchieved//目前已达到
} FlashBuyProductDetailPriceConfigStatus;

@interface FlashBuyProductDetailPriceConfig : NSObject
@property (nonatomic, assign) NSInteger peopleNum;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) FlashBuyProductDetailPriceConfigStatus priceStatus;
@property (nonatomic, strong) NSString *priceStatusName;
@end
