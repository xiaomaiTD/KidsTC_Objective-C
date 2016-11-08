//
//  AccountCenterConfig.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBanner.h"
#import "AccountCenterHotProduct.h"

@interface AccountCenterConfig : NSObject
@property (nonatomic, strong) NSArray<NSString *> *icons;
@property (nonatomic, strong) NSArray<AccountCenterBanner *> *banners;
@property (nonatomic, strong) AccountCenterHotProduct *hotProduct;
@end
