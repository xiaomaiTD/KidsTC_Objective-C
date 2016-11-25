//
//  CollectProductItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategory.h"

@interface CollectProductItem : NSObject
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *distanceDesc;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *endTimeDesc;
@property (nonatomic, strong) NSString *supplierIconImg;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *oldPcprice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *pcPrice;
@property (nonatomic, strong) NSString *markdownPrice;
@property (nonatomic, strong) NSString *mackdownPcPrice;
@property (nonatomic, assign) NSInteger interestType;
@property (nonatomic, strong) NSArray<CollectProductCategory *> *productCategory;
@property (nonatomic, strong) NSString *interesTime;
@end
