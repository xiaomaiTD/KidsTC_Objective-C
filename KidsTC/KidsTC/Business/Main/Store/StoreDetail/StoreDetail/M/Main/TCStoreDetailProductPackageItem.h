//
//  TCStoreDetailProductPackageItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum : NSUInteger {
    TCStoreDetailProductPackageItemTypeFightGroup = 1,
    TCStoreDetailProductPackageItemTypeSeckill,
} TCStoreDetailProductPackageItemType;

@interface TCStoreDetailProductPackageItem : NSObject
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *storePrice;
@property (nonatomic, strong) NSString *reducePrice;
@property (nonatomic, strong) NSString *ageGroup;
@property (nonatomic, strong) NSString *saleNum;
@property (nonatomic, assign) BOOL isShowStorePrice;
@property (nonatomic, assign) ProductDetailType productRedirectType;
@property (nonatomic, assign) TCStoreDetailProductPackageItemType productTagType;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
