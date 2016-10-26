//
//  ProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProductDetailViewActionTypeSegue = 1
} ProductDetailViewActionType;

@class ProductDetailView;
@protocol ProductDetailViewDelegate <NSObject>

- (void)productDetailView:(ProductDetailView *)view actionType:(ProductDetailViewActionType)type value:(id)value;

@end

@interface ProductDetailView : UIView
@property (nonatomic, weak) id<ProductDetailViewDelegate> delegate;
@end
