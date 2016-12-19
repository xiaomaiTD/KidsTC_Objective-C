//
//  ProductDetailAddressAnnoView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailAddressSelStoreModel.h"

typedef enum : NSUInteger {
    ProductDetailAddressAnnoViewActionTypeGoto =1,
} ProductDetailAddressAnnoViewActionType;

@class ProductDetailAddressAnnoView;
@protocol ProductDetailAddressAnnoViewDelegate <NSObject>
- (void)productDetailAddressAnnoView:(ProductDetailAddressAnnoView *)view actionType:(ProductDetailAddressAnnoViewActionType)type value:(id)vlaue;
@end

@interface ProductDetailAddressAnnoView : UIView
@property (nonatomic, strong) ProductDetailAddressSelStoreModel *place;
@property (nonatomic, weak) id<ProductDetailAddressAnnoViewDelegate> delegate;
@end
