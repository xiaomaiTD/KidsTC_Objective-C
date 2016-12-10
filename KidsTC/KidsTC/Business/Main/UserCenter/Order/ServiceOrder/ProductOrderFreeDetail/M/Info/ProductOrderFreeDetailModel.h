//
//  ProductOrderFreeDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailData.h"

@interface ProductOrderFreeDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductOrderFreeDetailData *data;
@end
