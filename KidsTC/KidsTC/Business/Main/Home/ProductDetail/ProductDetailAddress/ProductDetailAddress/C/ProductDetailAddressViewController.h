//
//  ProductDetailAddressViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailStore.h"

@interface ProductDetailAddressViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
