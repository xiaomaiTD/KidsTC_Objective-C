//
//  ProductDetailAddNewConsultViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    ProductDetailAddNewConsultViewControllerActionTypeReload = 1//当发布成功时，重新刷新页面
} ProductDetailAddNewConsultViewControllerActionType;

@class ProductDetailAddNewConsultViewController;
@protocol ProductDetailAddNewConsultViewControllerDelegate <NSObject>

- (void)productDetailAddNewConsultViewController:(ProductDetailAddNewConsultViewController *)controller actionType:(ProductDetailAddNewConsultViewControllerActionType)type value:(id)value;

@end

@interface ProductDetailAddNewConsultViewController : ViewController
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, weak) id<ProductDetailAddNewConsultViewControllerDelegate> delegate;
@end
