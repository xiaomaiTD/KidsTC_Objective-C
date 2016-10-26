//
//  ProductDetailStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailStore : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@end
