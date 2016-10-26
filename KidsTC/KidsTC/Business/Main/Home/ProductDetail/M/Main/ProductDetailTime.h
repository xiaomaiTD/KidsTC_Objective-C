//
//  ProductDetailTime.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTimeItem.h"

@interface ProductDetailTime : NSObject
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray<ProductDetailTimeItem *> *times;
@end
