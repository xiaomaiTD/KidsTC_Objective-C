//
//  ProductDetailFreeApplySelectPlaceViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailPlace.h"

@interface ProductDetailFreeApplySelectPlaceViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailPlace *> *places;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) void(^actionBlock)(NSInteger selectIndex);
@end
