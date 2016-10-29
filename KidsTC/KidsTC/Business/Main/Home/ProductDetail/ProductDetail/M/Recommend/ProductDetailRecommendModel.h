//
//  ProductDetailRecommendModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailRecommendItem.h"

@interface ProductDetailRecommendModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<ProductDetailRecommendItem *> *data;
@end
