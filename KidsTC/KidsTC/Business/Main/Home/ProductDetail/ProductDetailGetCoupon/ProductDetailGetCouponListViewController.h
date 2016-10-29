//
//  ProductDetailGetCouponListViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailGetCouponItem.h"

typedef enum : NSUInteger {
    ProductDetailGetCouponListViewControllerActionTypeSelect = 1,
} ProductDetailGetCouponListViewControllerActionType;

@class ProductDetailGetCouponListViewController;

@protocol ProductDetailGetCouponListViewControllerDelegate <NSObject>

- (void)productDetailGetCouponListViewController:(ProductDetailGetCouponListViewController *)controller actionType:(ProductDetailGetCouponListViewControllerActionType)type value:(id)value;

@end

@interface ProductDetailGetCouponListViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailGetCouponItem *> *coupons;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, weak) id<ProductDetailGetCouponListViewControllerDelegate> delegate;
@end
