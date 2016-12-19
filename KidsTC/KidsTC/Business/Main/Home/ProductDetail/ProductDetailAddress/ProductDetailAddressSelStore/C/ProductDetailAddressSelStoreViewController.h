//
//  ProductDetailAddressSelStoreViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailAddressSelStoreModel.h"

@class ProductDetailAddressSelStoreViewController;
@protocol ProductDetailAddressSelStoreViewControllerDelegate <NSObject>
- (void)productDetailAddressSelStoreViewController:(ProductDetailAddressSelStoreViewController *)controller didSelectIndex:(NSUInteger)index;
@end

@interface ProductDetailAddressSelStoreViewController : ViewController
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<ProductDetailAddressSelStoreModel *> *places;
@property (nonatomic, weak) id<ProductDetailAddressSelStoreViewControllerDelegate> delegate;
@end
