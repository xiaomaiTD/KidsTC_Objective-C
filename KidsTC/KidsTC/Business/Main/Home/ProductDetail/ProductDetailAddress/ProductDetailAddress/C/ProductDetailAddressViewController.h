//
//  ProductDetailAddressViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailAddressSelStoreModel.h"

@interface ProductDetailAddressViewController : ViewController
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<ProductDetailAddressSelStoreModel *> *places;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
