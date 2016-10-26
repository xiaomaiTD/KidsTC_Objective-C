//
//  ProductDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailData.h"

@interface ProductDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ProductDetailData *data;
@end
