//
//  RadishMallProduct.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
#import "RadishMallBanner.h"

typedef enum : NSUInteger {
    RadishMallProductTypePlant = 1,
    RadishMallProductTypeItems,
    RadishMallProductTypeLarge,
    RadishMallProductTypeSmall,
    RadishMallProductTypeBanner,
    RadishMallProductTypeHot,
} RadishMallProductType;

@interface RadishMallProduct : NSObject
@property (nonatomic, strong) NSString *radishSysNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString *buyCount;
@property (nonatomic, strong) NSString *radishCount;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) BOOL isShowPrice;
@property (nonatomic, strong) NSString *timeDesc;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *btnName;
@property (nonatomic, assign) BOOL canBuy;
//selfDefine
@property (nonatomic, assign) RadishMallProductType showType;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, strong) NSArray<RadishMallBanner *> *banners;
@end
