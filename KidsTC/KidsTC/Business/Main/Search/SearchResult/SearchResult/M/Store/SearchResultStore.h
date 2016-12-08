//
//  SearchResultStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResultStoreProduct.h"
#import "SegueModel.h"

@interface SearchResultStore : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSArray<SearchResultStoreProduct *> *products;
@property (nonatomic, strong) NSString *tradingAreaName;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
