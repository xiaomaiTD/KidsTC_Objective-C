//
//  TCStoreDetailProductPackage.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailProductPackageItem.h"

@interface TCStoreDetailProductPackage : NSObject
@property (nonatomic, strong) NSString *iconText;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<TCStoreDetailProductPackageItem *> *products;
//selfDefine
@property (nonatomic, assign) BOOL showMore;
@end
