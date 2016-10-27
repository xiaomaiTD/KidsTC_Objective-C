//
//  ProductDetailTwoColumnCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailBaseCell.h"

typedef enum : NSUInteger {
    ProductDetailTwoColumnShowTypeDetail=1,//详情
    ProductDetailTwoColumnShowTypeConsult//咨询
} ProductDetailTwoColumnShowType;


@interface ProductDetailTwoColumnCell : ProductDetailBaseCell
@property (nonatomic, assign) ProductDetailTwoColumnShowType showType;
@property (nonatomic, assign) BOOL webViewHasOpen;
@end
