//
//  ProductStandardViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailStandard.h"

typedef enum : NSUInteger {
    ProductStandardViewControllerActionTypDidSelectStandard = 1,
    ProductStandardViewControllerActionTypBuyStandard
} ProductStandardViewControllerActionTyp;

@class ProductStandardViewController;
@protocol ProductStandardViewControllerDelegate <NSObject>
- (void)productStandardViewController:(ProductStandardViewController *)controller actionType:(ProductStandardViewControllerActionTyp)type value:(id)value;
@end

@interface ProductStandardViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailStandard *> *product_standards;
@property (nonatomic, weak  ) id<ProductStandardViewControllerDelegate> delegate;
@end
