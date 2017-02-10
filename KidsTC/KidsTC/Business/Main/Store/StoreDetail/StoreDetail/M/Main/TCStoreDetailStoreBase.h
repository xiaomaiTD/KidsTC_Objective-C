//
//  TCStoreDetailStoreBase.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCStoreDetailStoreBase : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeSimpleName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *logoImg;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, strong) NSString *verifyImg;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
//selfDefine
@property (nonatomic, strong) NSArray<NSString *> *phones;
@property (nonatomic, assign) BOOL webViewHasLoad;
@end
