//
//  ProductDetailAddressTitleView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProductDetailAddressTitleViewActionTypeTexi=1,
    ProductDetailAddressTitleViewActionTypeBus,
    ProductDetailAddressTitleViewActionTypeWorlk,
} ProductDetailAddressTitleViewActionType;

@class ProductDetailAddressTitleView;
@protocol ProductDetailAddressTitleViewDelegate <NSObject>
- (void)productDetailAddressTitleView:(ProductDetailAddressTitleView *)view
                           actionType:(ProductDetailAddressTitleViewActionType)type
                                value:(id)value;
@end

@interface ProductDetailAddressTitleView : UIView
@property (nonatomic, weak) id<ProductDetailAddressTitleViewDelegate> delegate;
@end
