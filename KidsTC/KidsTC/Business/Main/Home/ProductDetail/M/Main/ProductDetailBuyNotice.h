//
//  ProductDetailBuyNotice.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailNotice.h"

@interface ProductDetailBuyNotice : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<ProductDetailNotice *> *notice;
@end
