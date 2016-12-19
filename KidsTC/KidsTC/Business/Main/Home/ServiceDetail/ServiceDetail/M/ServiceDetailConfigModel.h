//
//  ServiceDetailConfigModel.h
//  KidsTC
//
//  Created by zhanping on 6/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceDetailConfigStoreItem : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger commentAverage;
@property (nonatomic, strong) NSString *distance;
@end

@interface ServiceDetailConfigData : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *chid;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, assign) double storePrice;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) NSUInteger minBuyNum;
@property (nonatomic, assign) NSUInteger maxBuyNum;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *remainStock;
@property (nonatomic, strong) NSArray<ServiceDetailConfigStoreItem *> *stores;
@end

@interface ServiceDetailConfigModel : NSObject
@property (nonatomic, strong) ServiceDetailConfigData *data;
@end
