//
//  ProductStandardDetailStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductStandardDetailStore : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger commentAverage;
@property (nonatomic, strong) NSString *distance;
@end
