//
//  CollectionStoreItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreCoupon.h"
#import "CollectionStoreProduct.h"
#import "SegueModel.h"

@interface CollectionStoreItem : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeImg;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *interestNum;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, assign) NSInteger newsCount;
@property (nonatomic, strong) NSString *saleNum;
@property (nonatomic, strong) NSArray<CollectionStoreCoupon *> *couponModeLst;
@property (nonatomic, strong) NSArray<CollectionStoreProduct *> *productLst;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
