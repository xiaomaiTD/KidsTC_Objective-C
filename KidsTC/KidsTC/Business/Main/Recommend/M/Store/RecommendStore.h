//
//  RecommendStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreProduct.h"
#import "SegueModel.h"

@interface RecommendStore : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeImg;
@property (nonatomic, strong) NSString *storeImgRatio;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *newsCount;
@property (nonatomic, strong) NSString *saleNum;
@property (nonatomic, strong) NSString *interestNum;
@property (nonatomic, assign) BOOL isInterest;
@property (nonatomic, strong) NSArray<RecommendStoreProduct *> *productLst;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
