//
//  ProductDetailFreeApplySelectStoreViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailStore.h"

@interface ProductDetailFreeApplySelectStoreViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailStore *> *stores;
@property (nonatomic, copy) void(^pickStoreBlock)(ProductDetailStore *store);
@end
