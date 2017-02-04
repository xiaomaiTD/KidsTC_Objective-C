//
//  NormalProductDetailStore.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailStore : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *distance;
//selfDefine
@property (nonatomic, strong) NSArray<NSString *> *phones;
//select
@property (nonatomic, assign) BOOL selected;

- (void)setupStoreInfo;
@end
