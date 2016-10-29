//
//  ProductDetailConsultModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailConsultItem.h"
@interface ProductDetailConsultModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
//selfDefine
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *items;
@end
