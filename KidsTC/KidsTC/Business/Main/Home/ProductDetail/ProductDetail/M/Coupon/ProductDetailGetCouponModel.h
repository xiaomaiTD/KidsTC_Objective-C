//
//  ProductDetailGetCouponModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailGetCouponItem.h"
@interface ProductDetailGetCouponModel : NSObject
@property (nonatomic, strong) NSArray<ProductDetailGetCouponItem *> *data;
@end
